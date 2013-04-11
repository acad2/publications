//
//  Topic.cs
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

namespace PaperMiners.Miners {

	[Flags]
	public enum Topic : long {
		None	= 0x0000000000000000,
		AI		= 0x0000000000000001,
		CL		= 0x0000000000000002,
		CC		= 0x0000000000000004,
		CE		= 0x0000000000000008,
		CG		= 0x0000000000000010,
		GT		= 0x0000000000000020,
		CV		= 0x0000000000000040,
		CY		= 0x0000000000000080,
		CR		= 0x0000000000000100,
		DS		= 0x0000000000000200,
		DB		= 0x0000000000000400,
		DL		= 0x0000000000000800,
		DM		= 0x0000000000001000,
		DC		= 0x0000000000002000,
		ET		= 0x0000000000004000,
		FL		= 0x0000000000008000,
		GL		= 0x0000000000010000,
		GR		= 0x0000000000020000,
		AR		= 0x0000000000040000,
		HC		= 0x0000000000080000,
		IR		= 0x0000000000100000,
		IT		= 0x0000000000200000,
		LG		= 0x0000000000400000,
		LO		= 0x0000000000800000,
		MS		= 0x0000000001000000,
		MA		= 0x0000000002000000,
		MM		= 0x0000000004000000,
		NI		= 0x0000000008000000,
		NE		= 0x0000000010000000,
		NA		= 0x0000000020000000,
		OS		= 0x0000000040000000,
		OH		= 0x0000000080000000,
		PF		= 0x0000000100000000,
		PL		= 0x0000000200000000,
		RO		= 0x0000000400000000,
		SI		= 0x0000000800000000,
		SE		= 0x0000001000000000,
		SD		= 0x0000002000000000,
		SC		= 0x0000004000000000,
		SY		= 0x0000008000000000
	}
}

