//
//  Library.cs
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
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using System.Xml.Serialization;

namespace PaperMiners {

	[XmlRoot("Library")]
	public class Library {

		private readonly HashSet<Paper> occurenceCheck = new HashSet<Paper>();
		private List<Paper> papers = new List<Paper>();
		private Blob blob;
		private string blobPath;

		[XmlArray("Papers")]
		[XmlArrayItem("Paper")]
		public List<Paper> Papers {
			get {
				return this.papers;
			}
			set {
				this.papers = value;
				this.occurenceCheck.Clear();
				foreach(Paper pap in value) {
					this.occurenceCheck.Add(pap);
				}
			}
		}
		[XmlAttribute("BlobPath")]
		public string BlobPath {
			get {
				return this.blobPath;
			}
			set {
				this.blobPath = value;
				if(this.blobPath != null && this.blobPath != string.Empty) {
					this.blob = new Blob(this.blobPath);
				}
				else {
					this.blob = null;
				}
			}
		}

		public Library () {
			this.papers = new List<Paper>();
			this.occurenceCheck = new HashSet<Paper>();
		}

		public static Library LoadFromStream (Stream stream) {
			XmlSerializer xmls = new XmlSerializer(typeof(Library));
			return (Library)xmls.Deserialize(stream);

		}

		[MethodImpl(MethodImplOptions.Synchronized)]
		public void AddPaper (Paper paper) {
			if(this.occurenceCheck.Add(paper)) {
				this.papers.Add(paper);
				paper.StoreInBlob(this.blob);
			}
		}

	}
}