//
//  ArXivPaperMiner.cs
//
//  Author:
//       Willem Van Onsem <vanonsem.willem@gmail.com>
//
//  Copyright (c) 2013 Willem Van Onsem
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
using System;
using System.Collections.Generic;
using System.Net;
using System.Text.RegularExpressions;
using System.Linq;
using System.Xml.Linq;
using System.Web;

/*
ArXiv data tree:
 - dd
   - div (meta)
     - div (list-title)
       - span (descriptor)
     - div (list-authors)
       - span (descriptor)
       - a*
     - div (list-comments)
       - span (descriptor)
     - div (list-subjects)
       - span (descriptor)
       - span (primary-subject)
*/

namespace PaperMiners {

	public class ArXivPaperMiner : PaperMiner {

		private static readonly Regex rx_title = new Regex(@"(title:[ \t\n]*)?(?<title>.*)", RegexOptions.Compiled|RegexOptions.CultureInvariant|RegexOptions.ExplicitCapture|RegexOptions.IgnoreCase);
		private static readonly Regex rx_comme = new Regex(@"(comments:[ \t\n]*)?(?<comments>.*)", RegexOptions.Compiled|RegexOptions.CultureInvariant|RegexOptions.ExplicitCapture|RegexOptions.IgnoreCase);
		private static readonly Regex rx_subje = new Regex(@"[^(]*\(cs.(?<subject>[A-Z]{2})\)", RegexOptions.Compiled|RegexOptions.CultureInvariant|RegexOptions.ExplicitCapture|RegexOptions.IgnoreCase);
		private static readonly Dictionary<string,ArXivTopic> topicCache = new Dictionary<string,ArXivTopic>();

		public ArXivPaperMiner () {
			if(topicCache.Count <= 0x00) {
				foreach(ArXivTopic at in Enum.GetValues(typeof(ArXivTopic))) {
					topicCache.Add(at.ToString(), at);
				}
			}
		}

		public override Paper[] FetchPapers () {
			List<Paper> papers = new List<Paper>();
			List<string> links = new List<string>();
			IEnumerable<XElement> xe1s, xe2s;
			XElement xe3;
			WebClient wc = new WebClient();
			string title, comment;
			string[] authors;
			ArXivTopic primary, topic;
			int i;
			foreach(ArXivTopic at in Enum.GetValues(typeof(ArXivTopic))) {
				if(((long)at) != 0x00) {
					wc.UseDefaultCredentials = true;
					wc.Headers.Add("user-agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6)");
					XDocument xd = HtmlUtils.ToXDocument(wc.DownloadString("http://arxiv.org/list/cs."+at.ToString()+"/recent"));
					//Console.WriteLine(xd);
					xe1s = from el in xd.Descendants("{http://www.w3.org/1999/xhtml}dt").Elements("{http://www.w3.org/1999/xhtml}span") where el.Attribute("class").Value == "list-identifier" select el;
					links.Clear();
					foreach(XElement xe1 in xe1s) {
						links.Add(ObtainLink(xe1.Elements("{http://www.w3.org/1999/xhtml}a")));
					}
					xe1s = from el in xd.Descendants("{http://www.w3.org/1999/xhtml}dd").Elements("{http://www.w3.org/1999/xhtml}div") where el.Attribute("class").Value == "meta" select el;
					i = 0;
					foreach(XElement xe1 in xe1s) {
						title = string.Empty;
						authors = null;
						comment = string.Empty;
						primary = ArXivTopic.None;
						topic = ArXivTopic.None;
						xe2s = from el in xe1.Descendants("{http://www.w3.org/1999/xhtml}div") where el.Attribute("class").Value == "list-title" select el;
						title = ObtainTitle(xe2s.First());
						xe2s = from el in xe1.Descendants("{http://www.w3.org/1999/xhtml}div") where el.Attribute("class").Value == "list-authors" select el;
						authors = (from el in xe2s.Elements("{http://www.w3.org/1999/xhtml}a") select HttpUtility.HtmlDecode(el.Value.Trim())).ToArray();
						xe2s = from el in xe1.Descendants("{http://www.w3.org/1999/xhtml}div") where el.Attribute("class").Value == "list-comments" select el;
						comment = ObtainComment(xe2s.FirstOrDefault());
						xe2s = from el in xe1.Descendants("{http://www.w3.org/1999/xhtml}div") where el.Attribute("class").Value == "list-subjects" select el;
						xe3 = xe2s.Elements("{http://www.w3.org/1999/xhtml}span").Where(x => x.Attribute("class").Value == "primary-subject").FirstOrDefault();
						if(xe3 != null) {
							primary = ReadTopics(xe3.Value);
						}
						topic = ReadTopics(xe2s.First().Value);
						papers.Add(new Paper("ArXiv", "http://arxiv.org"+links[i], ArXivTopicToTopic(primary), ArXivTopicToTopic(topic), title, authors, comment));
						i++;
					}
				}
			}
			return papers.ToArray();
		}

		public static string ObtainLink (IEnumerable<XElement> xes) {
			XElement xe = xes.Where(x => x.Attribute("title").Value == "Download PDF").FirstOrDefault();
			if(xe != null) {
				return xe.Attribute("href").Value+".pdf";
			}
			xe = xes.Where(x => x.Attribute("title").Value == "Download PostScript").FirstOrDefault();
			if(xe != null) {
				return xe.Attribute("href").Value+".ps";
			}
			return "/404.html";
		}

		public static string ObtainTitle (XElement titleElement) {
			return HttpUtility.HtmlDecode(rx_title.Match(titleElement.Value).Groups[1].Value.Trim());
		}
		public static string ObtainComment (XElement commentElement) {
			if(commentElement != null) {
				return HttpUtility.HtmlDecode(rx_comme.Match(commentElement.Value).Groups[1].Value.Trim());
			}
			else {
				return null;
			}
		}

		public static ArXivTopic ReadTopics (string text) {
			ArXivTopic top = ArXivTopic.None;
			foreach(Match m in rx_subje.Matches(text)) {
				top |= topicCache[m.Groups[1].Value];
			}
			return top;
		}

		public static Topic ArXivTopicToTopic (ArXivTopic topic) {
			return (Topic)(long)topic;
		}

	}
}

