//
//  MainWindow.cs
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
using System.Linq;
using Gtk;
using System.Reflection;
using Glade;
using PaperMiners.Miners;
using PaperMiners.Util;

namespace PaperMiners.UserInterface {

	public class MainWindow {

		TreeStore treeStore = new TreeStore(typeof(string), typeof(string));

		[Glade.Widget]
		TreeView
			overview;

		public MainWindow (Library library) {
			Glade.XML gxml = new Glade.XML(null, "PaperMiners.MainWindow.glade", "mainwindow", null);
			gxml.Autoconnect(this);
			overview.Model = treeStore;

			Gtk.TreeViewColumn artistColumn = new Gtk.TreeViewColumn();
			artistColumn.Title = "Authors";
 
			Gtk.CellRendererText artistNameCell = new Gtk.CellRendererText();
 
			artistColumn.PackStart(artistNameCell, true);
 
			Gtk.TreeViewColumn songColumn = new Gtk.TreeViewColumn();
			songColumn.Title = "Title";
 
			Gtk.CellRendererText songTitleCell = new Gtk.CellRendererText();
			songColumn.PackStart(songTitleCell, true);

			artistColumn.AddAttribute(artistNameCell, "text", 0);
			songColumn.AddAttribute(songTitleCell, "text", 1);
			foreach(Topic topic in Enum.GetValues(typeof(Topic))) {
				if(topic != Topic.None) {
					TreeIter iter = treeStore.AppendValues(Utils.TopicName(topic));
					foreach(Paper pap in library.Papers.Where(x => x.MainTopic == topic)) {
						treeStore.AppendValues(iter, string.Join("\n", pap.Authors), pap.Title);
					}
				}
			}
 
			overview.AppendColumn(artistColumn);
			overview.AppendColumn(songColumn);
		}

		public static int Main (string[] args) {
			Application.Init();
			FileStream fs = File.Open("library.xml", FileMode.Open, FileAccess.Read);
			new MainWindow(Library.LoadFromStream(fs));
			fs.Close();
			Application.Run();
			return 0;
		}

	}
}

