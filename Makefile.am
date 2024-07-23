##-*- makefile -*-############################################################
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Wed Jul 29 12:28:40 2020
#  Last Modified : <240723.1703>
#
#  Description	
#
#  Notes
#
#  History
#	
#  $Log$
#
##############################################################################
#
#    Copyright (C) 2020  Robert Heller D/B/A Deepwoods Software
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
#
# 
#
##############################################################################


ACLOCAL_AMFLAGS = -I m4
SUBDIRS = BuildScripts Scripts
EXTRA_DIST = bootstrap TkMailList.tcl

bin_SCRIPTS = TkMailList$(EXEEXT)

CLEANFILES  = TkMailList.kit $(bin_SCRIPTS)

AddKitDir = $(top_srcdir)/BuildScripts/AddKitDir.kit
AddKitFile = $(top_srcdir)/BuildScripts/AddKitFile.kit
MakePkgIndex = $(top_srcdir)/BuildScripts/MakePkgIndex.kit

TkMailListScripts = Scripts/IconsAndImages.tcl \
		Scripts/ReadConfiguration.tcl Scripts/snitdialog.tcl \
		Scripts/snitLFs.tcl Scripts/snitbuttonbox.tcl \
		Scripts/unknown.xpm Scripts/HaveMail.png \
		Scripts/NoMail.png

TkMailList$(EXEEXT): TkMailList.tcl $(TkMailListScripts)
	-rm -rf TkMailList.vfs TkMailList.kit
	$(TCLKIT) $(SDX) qwrap $(srcdir)/TkMailList.tcl
	$(TCLKIT) $(SDX) unwrap TkMailList.kit
	-rm -rf TkMailList.kit
	$(TCLKIT) $(AddKitDir) TkMailList lib $(SNITLIB)
	$(TCLKIT) $(AddKitDir) TkMailList lib $(IMAP4LIB)
	$(TCLKIT) $(AddKitDir) TkMailList lib $(TLSLIB)
	$(TCLKIT) $(AddKitDir) TkMailList lib $(IMGLIB)
	$(TCLKIT) $(AddKitFile) -srcdir $(srcdir) TkMailList \
		lib/Common $(TkMailListScripts)
	$(TCLKIT) $(MakePkgIndex) TkMailList Common
	cp $(TCLKIT) runtime$(EXEEXT)
	$(TCLKIT) $(SDX) wrap TkMailList$(EXEEXT) -runtime runtime$(EXEEXT)
	rm -rf runtime$(EXEEXT) TkMailList.vfs
