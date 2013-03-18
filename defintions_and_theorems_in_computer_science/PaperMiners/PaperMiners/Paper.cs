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
using System;
using System.Xml.Serialization;

namespace PaperMiners {

	[XmlType("Paper")]
	public class Paper {

		[XmlAttribute("Title")]
		public string Title {
			get;
			set;
		}

		[XmlAttribute("Author")]
		public string Author {
			get;
			set;
		}

		[XmlAttribute("MainTopic")]
		public Topic MainTopic {
			get;
			set;
		}

		[XmlAttribute("Topic")]
		public Topic Topic {
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

		public Paper (string source, string url, Topic topic) {
			this.Source = source;
			this.Url = url;
			this.Topic = topic;
		}

		public override bool Equals (object obj) {
			if(obj is Paper) {
				Paper pobj = (Paper)obj;
				return pobj.Author == this.Author && pobj.Title == this.Title;
			}
			else {
				return false;
			}
		}

	}
}

