//
//  MainClass.cs
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
using System.IO;
using System.Xml.Serialization;
using PaperMiners.Miners;

namespace PaperMiners {

	public class MainClass {

		/*public static void Main () {
			Library library = new Library();
			ArXivPaperMiner apm = new ArXivPaperMiner();
			foreach(Paper pap in apm.FetchPapers()) {
				library.Papers.Add(pap);
			}
			XmlSerializer xs = new XmlSerializer(typeof(Library));
			FileStream fs = File.Open("library.xml", FileMode.Create, FileAccess.Write);
			xs.Serialize(fs, library);
			fs.Close();
		}*/

	}
}

