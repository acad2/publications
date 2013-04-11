//
//  DictionaryProxy.cs
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

namespace System.Xml.Serialization {

	[XmlType("Dictionary")]
	public class DictionaryProxy<TKey,TValue> : IDictionary<TKey,TValue> {

		public readonly IDictionary<TKey,TValue> InnerDictionary;

		#region ICollection implementation
		[XmlIgnore]
		public int Count {
			get {
				return this.InnerDictionary.Count;
			}
		}

		[XmlIgnore]
		public bool IsReadOnly {
			get {
				return this.InnerDictionary.IsReadOnly;
			}
		}
		#endregion

		#region IDictionary implementation
		[XmlIgnore]
		public TValue this [TKey key] {
			get {
				return this.InnerDictionary[key];
			}
			set {
				this.InnerDictionary[key] = value;
			}
		}

		[XmlIgnore]
		public ICollection<TKey> Keys {
			get {
				return this.InnerDictionary.Keys;
			}
		}

		[XmlIgnore]
		public ICollection<TValue> Values {
			get {
				return this.InnerDictionary.Values;
			}
		}
		#endregion

		[XmlArray("Items")]
		[XmlArrayItem("Item")]
		public IEnumerable<KeyValuePair<TKey,TValue>> Items {
			get {
				foreach(KeyValuePair<TKey,TValue> item in this.InnerDictionary) {
					yield return item;
				}
			}
			set {
				this.Clear();
				foreach(KeyValuePair<TKey,TValue> item in value) {
					this.Add(item);
				}
			}
		}

		public DictionaryProxy () {
			this.InnerDictionary = new Dictionary<TKey,TValue>();
		}

		public DictionaryProxy (IDictionary<TKey,TValue> innerDictionary) {
			this.InnerDictionary = innerDictionary;
		}

		#region IEnumerable implementation
		public System.Collections.IEnumerator GetEnumerator () {
			return ((System.Collections.IEnumerable)this.InnerDictionary).GetEnumerator();
		}
		#endregion

		#region IEnumerable implementation
		IEnumerator<KeyValuePair<TKey, TValue>> IEnumerable<KeyValuePair<TKey, TValue>>.GetEnumerator () {
			return ((IEnumerable<KeyValuePair<TKey,TValue>>)this.InnerDictionary).GetEnumerator();
		}
		#endregion

		#region ICollection implementation
		public void Add (KeyValuePair<TKey, TValue> item) {
			this.InnerDictionary.Add(item);
		}

		public void Clear () {
			this.InnerDictionary.Clear();
		}

		public bool Contains (KeyValuePair<TKey, TValue> item) {
			return this.InnerDictionary.Contains(item);
		}

		public void CopyTo (KeyValuePair<TKey, TValue>[] array, int arrayIndex) {
			this.InnerDictionary.CopyTo(array, arrayIndex);
		}

		public bool Remove (KeyValuePair<TKey, TValue> item) {
			return this.InnerDictionary.Remove(item);
		}
		#endregion

		#region IDictionary implementation
		public void Add (TKey key, TValue value) {
			this.InnerDictionary.Add(key, value);
		}

		public bool ContainsKey (TKey key) {
			return this.ContainsKey(key);
		}

		public bool Remove (TKey key) {
			return this.Remove(key);
		}

		public bool TryGetValue (TKey key, out TValue value) {
			return this.InnerDictionary.TryGetValue(key, out value);
		}
		#endregion


	}
}

