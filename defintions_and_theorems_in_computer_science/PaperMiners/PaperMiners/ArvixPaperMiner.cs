//
//  ArvixPaperMiner.cs
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
using System.Net;
using System.Threading;
using System.Web;
using System.Xml.Linq;

namespace PaperMiners {

	public class ArvixPaperMiner : PaperMiner {

		public ArvixPaperMiner () {
		}

		public override Paper[] FetchPapers () {
			WebClient wc = new WebClient();
			foreach(ArvixTopic at in Enum.GetValues(typeof(ArvixTopic))) {
				if(((long)at) != 0x00) {
					Console.WriteLine("Trying "+"http://arxiv.org/list/cs."+at.ToString()+"/recent");
					wc.UseDefaultCredentials = true;
					wc.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
					string s = wc.DownloadString("http://arxiv.org/list/cs."+at.ToString()+"/recent");
					string y = "";
					for(int i = 0; i < s.Length; i++) {
						if(s[i] == '<' || s[i] == '>' || s[i] == '"') {
							y += s[i];
						}
						else {
							y += HttpUtility.HtmlEncode(s[i].ToString());
						}
					}
					Console.WriteLine(y);
					XDocument xd = XDocument.Parse(y);

					foreach(XElement xe in xd.Descendants("{http://www.w3.org/1999/xhtml}dd")) {
						Console.WriteLine(xe.Value);
						/*foreach(XElement xe2 in xe.Descendants()) {
							Console.WriteLine(xe2.Value);
						}*/
					}
					Thread.Sleep(100000);
				}
			}
			return null;
		}

	}
}

