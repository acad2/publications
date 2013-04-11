//
//  Utils.cs
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
using System.Text;
using System.Collections.Generic;
using PaperMiners.Miners;

namespace PaperMiners.Util {

	public static class Utils {

		private static readonly string[] topicnames = new string[] {
			"None",
			"Artificial Intelligence",
			"Computation and Language",
			"Computational Complexity",
			"Computational Engineering, Finance, and Science",
			"Computational Geometry",
			"Computer Science and Game Theory",
			"Computer Vision and Pattern Recognition",
			"Computer and Society",
			"Cryptography and Security",
			"Datastructures and Algorithms",
			"Databases",
			"Digital Libraries",
			"Discrete Mathematics",
			"Distributed, Parallel and Cluster Computing",
			"Emerging Technologies",
			"Formal Languages and Automata Theory",
			"General Literature",
			"Graphics",
			"Hardware Architecture",
			"Human-Computer Interaction",
			"Information Retrieval",
			"Information Theory",
			"Machine Learning",
			"Logic in Computer Science",
			"Mathematical Software",
			"Multiagent Systems",
			"Multimedia",
			"Networking and Internet Architecture",
			"Neural and Evolutionary Computing",
			"Numerical Analysis",
			"Operating Systems",
			"Other",
			"Performance",
			"Programming Languages",
			"Robotics",
			"Social and Information Networks",
			"Software Engineering",
			"Sound",
			"Symbolic Computation",
			"Systems and Control"
		};

		public static bool EqualEnumerable<T,Q> (IEnumerable<T> ea, IEnumerable<Q> eb) {
			IEnumerator<T> ena = ea.GetEnumerator();
			IEnumerator<Q> enb = eb.GetEnumerator();
			bool mna = ena.MoveNext(), mnb = enb.MoveNext();
			while(mna && mnb) {
				if(!ena.Current.Equals(enb.Current)) {
					return false;
				}
				mna = ena.MoveNext();
				mnb = ena.MoveNext();
			}
			return (mna == mnb);
		}

		public static int HashEnumerable<T> (IEnumerable<T> enumerable) {
			int hash = 0x00;
			foreach(T t in enumerable) {
				hash ^= t.GetHashCode();
			}
			return hash;
		}

		public static int IntegerLog2 (long value) {
			int index = -1;
			while(value != 0x00) {
				value >>= 0x01;
				index++;
			}
			return index;
		}

		public static string TopicName (Topic top) {
			return string.Format("{0} ({1})", topicnames[IntegerLog2((long)top)+0x01], top.ToString());
		}

		public static string ToCommaAnd (IEnumerable<string> items) {
			IEnumerator<string> ien = items.GetEnumerator();
			StringBuilder sb = new StringBuilder();
			if(ien.MoveNext()) {
				sb.Append(ien.Current);
				bool nxt = ien.MoveNext();
				if(nxt) {
					string val = ien.Current;
					while(nxt) {
						nxt = ien.MoveNext();
						if(nxt) {
							sb.AppendFormat(", {0}", val);
							val = ien.Current;
						}
						else {
							sb.AppendFormat(" and {0}", val);
						}
					}
				}
			}
			return sb.ToString();
		}

	}
}

