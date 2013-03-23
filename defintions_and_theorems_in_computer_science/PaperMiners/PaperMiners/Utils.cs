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
using System.Collections.Generic;

namespace PaperMiners {

	public static class Utils {


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

	}
}

