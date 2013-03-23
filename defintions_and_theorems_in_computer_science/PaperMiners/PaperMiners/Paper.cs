//
//  Paper.cs
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
using System.Net;
using System.Xml.Serialization;

namespace PaperMiners {

	[XmlType("Paper")]
	public class Paper {

		[XmlAttribute("Title")]
		public string Title {
			get;
			set;
		}

		[XmlArray("Authors")]
		[XmlArrayItem("Author")]
		public string[] Authors {
			get;
			set;
		}

		[XmlAttribute("MainTopic")]
		public Topic MainTopic {
			get;
			set;
		}

		[XmlAttribute("Topics")]
		public Topic Topics {
			get;
			set;
		}

		[XmlAttribute("Url")]
		public string Url {
			get;
			set;
		}

		[XmlAttribute("Source")]
		public string Source {
			get;
			set;
		}

		[XmlAttribute("Comment")]
		public string Comment {
			get;
			set;
		}

		public Paper () {
		}

		public Paper (string source, string url, Topic mainTopic, Topic topics, string title, string[] authors, string comment = "") {
			this.Source = source;
			this.Url = url;
			this.MainTopic = mainTopic;
			this.Topics = topics;
			this.Title = title;
			this.Authors = authors;
			this.Comment = comment;
		}

		public override bool Equals (object obj) {
			if(obj is Paper) {
				Paper pobj = (Paper)obj;
				return Utils.EqualEnumerable(pobj.Authors, this.Authors) && pobj.Title == this.Title;
			}
			else {
				return false;
			}
		}
		public override int GetHashCode () {
			return this.Title.GetHashCode()^Utils.HashEnumerable(this.Authors);
		}

		public void StoreInBlob (Blob blob) {
			WebClient wc = new WebClient();
			wc.UseDefaultCredentials = true;
			wc.Headers.Add("user-agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6)");
			blob.AddData(wc.DownloadData(this.Url));
		}

	}
}

