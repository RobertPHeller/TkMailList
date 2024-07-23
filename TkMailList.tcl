#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Tue Jul 23 16:56:44 2024
#  Last Modified : <240723.1720>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
## @copyright
#    Copyright (C) 2024  Robert Heller D/B/A Deepwoods Software
#			51 Locke Hill Road
#			Wendell, MA 01379-9728
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# @file TkMailList.tcl
# @author Robert Heller
# @date Tue Jul 23 16:56:44 2024
# 
#
#*****************************************************************************


set argv0 [file join [file dirname [info nameofexecutable]] [file rootname [file tail [info script]]]]


package require Tk
package require tile
package require tls
package require imap4
set ::imap4::use_ssl 1

package require snit

package require ReadConfiguration
package require IconImage

namespace eval TkRemoteBiff {
    snit::type Configuration {
        ::ReadConfiguration::ConfigurationType \
              {"Mail Server Host" mailServer string mail.deepsoft.com} \
              {"User Name" userName string {}} \
              {"Password" password string {}} \
              {"New Mail Sound" newMail infile /usr/share/sounds/freedesktop/stereo/message.oga} \
              {"New Mail Notifications" notify boolean false} \
              {"Check Interface (seconds)" interval integer 30 {1 150 1}}
    }
    Configuration load
    pack [frame .lf] -fill both -expand yes
    pack [ttk::treeview .lf.list \
          -columns {index from date size subject} \
          -displaycolumns {index from date size subject} \
          -selectmode none \
          -show headings] -side left -fill both -expand yes
    .lf.list heading index -text {#} -anchor e
    .lf.list heading from -text {From} -anchor w
    .lf.list heading date -text {Date} -anchor w
    .lf.list heading size -text {Size} -anchor e
    .lf.list heading subject -text {Subject} -anchor w
    .lf.list column index -stretch no  -anchor e -width 25
    .lf.list column from -stretch no -anchor w -width 100
    .lf.list column date -stretch no -anchor w -width 75
    .lf.list column size -stretch no -anchor e -width 50
    .lf.list column subject -stretch yes -anchor w -width 100
    pack [scrollbar .lf.vscroll -orient vertical -command [list .lf.list yview]] -side right -fill y
    .lf.list configure -yscrollcommand [list .lf.vscroll set]
    pack [ttk::button .dismis -text "Dismis" \
          -command ::exit] -fill x
    wm protocol . WM_DELETE_WINDOW ".dismis invoke"
    .lf.list delete [.lf.list children {}]
    set server [TkRemoteBiff::Configuration getoption mailServer]
    set username [TkRemoteBiff::Configuration getoption userName]
    set password [TkRemoteBiff::Configuration getoption password]
    set chan [::imap4::open $server]
    ::imap4::login $chan $username $password
    ::imap4::examine $chan
    set count [::imap4::mboxinfo $chan EXISTS]
    if {$count > 0} {
        ::imap4::fetch $chan 1: from: date: size subject:
        for {set i 1} {$i <= $count} {incr i} {
            set record [list \
                        [format {%d} $i] \
                        [format {%s} [::imap4::msginfo $chan $i from:]] \
                        [format {%s} [::imap4::msginfo $chan $i date:]] \
                        [format {%d} [::imap4::msginfo $chan $i size]] \
                        [format {%s} [::imap4::msginfo $chan $i subject:]]]
            .lf.list insert {} end -values $record
        }
    }
    ::imap4::cleanup $chan
}

