#* 
#* ------------------------------------------------------------------
#* ax_tcl_libraries.m4 - Checks for Tcl Libraries
#* Created by Robert Heller on Sat Mar  2 15:25:28 2013
#* ------------------------------------------------------------------
#* Modification History: $Log: headerfile.text,v $
#* Modification History: Revision 1.1  2002/07/28 14:03:50  heller
#* Modification History: Add it copyright notice headers
#* Modification History:
#* ------------------------------------------------------------------
#* Contents:
#* ------------------------------------------------------------------
#*  
#*     Generic Project
#*     Copyright (C) 2010  Robert Heller D/B/A Deepwoods Software
#* 			51 Locke Hill Road
#* 			Wendell, MA 01379-9728
#* 
#*     This program is free software; you can redistribute it and/or modify
#*     it under the terms of the GNU General Public License as published by
#*     the Free Software Foundation; either version 2 of the License, or
#*     (at your option) any later version.
#* 
#*     This program is distributed in the hope that it will be useful,
#*     but WITHOUT ANY WARRANTY; without even the implied warranty of
#*     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#*     GNU General Public License for more details.
#* 
#*     You should have received a copy of the GNU General Public License
#*     along with this program; if not, write to the Free Software
#*     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#* 
#*  
#* 

AC_DEFUN([AX_SNIT],[
AC_MSG_CHECKING(snit dir)
searchdirs=`echo 'puts $auto_path'|${TCLSH_PROG}`
for dir in $searchdirs ; do
  dirs="${dir}/snit* ${dir}/tcllib*/snit*"
  for i in $dirs ; do
    if test -d "$i" -a -f "$i/pkgIndex.tcl"; then
      SNITLIB=`cd $i; pwd`
    fi
  done
done
AC_ARG_WITH(snitlib, [  --with-snitlib=DIR          use snit from DIR], SNITLIB=$withval,)
if test x$SNITLIB != x -a -d $SNITLIB; then
   AC_MSG_RESULT([using snit library in $SNITLIB])
else
   AC_MSG_ERROR(Snit library directory not found)
fi
AC_SUBST(SNITLIB)
])

AC_DEFUN([AX_IMAP4],[
AC_MSG_CHECKING(imap4 dir)
searchdirs=`echo 'puts $auto_path'|${TCLSH_PROG}`
for dir in $searchdirs ; do
  dirs="${dir}/imap4* ${dir}/tcllib*/imap4*"
  for i in $dirs ; do
    if test -d "$i" -a -f "$i/pkgIndex.tcl"; then
      IMAP4LIB=`cd $i; pwd`
    fi
  done
done
AC_ARG_WITH(imap4lib, [  --with-imap4lib=DIR          use imap4 from DIR], IMAP4LIB=$withval,)
if test x$IMAP4LIB != x -a -d $IMAP4LIB; then
   AC_MSG_RESULT([using imap4 library in $IMAP4LIB])
else
   AC_MSG_ERROR(Imap4 library directory not found)
fi
AC_SUBST(IMAP4LIB)
])

AC_DEFUN([AX_TLS],[
AC_MSG_CHECKING(tls dir)
searchdirs=`echo 'puts $auto_path'|${TCLSH_PROG}`
for dir in $searchdirs ; do
   dirs="${dir}/*tls*"
   for i in $dirs ; do
       if test -d "$i" -a -f "$i/pkgIndex.tcl"; then
          TLSLIB=`cd $i; pwd`
       fi
   done
done
AC_ARG_WITH(tlslib, [  --with-tlslib=DIR          use tls from DIR], TLSLIB=$withval,)
if test x$TLSLIB != x -a -d $TLSLIB; then
  AC_MSG_RESULT([using tls library in $TLSLIB])
else
  AC_MSG_ERROR(Tls library directory not found)
fi
AC_SUBST(TLSLIB)
])

AC_DEFUN([AX_IMG],[
AC_MSG_CHECKING(img dir)
searchdirs=`echo 'puts $auto_path'|${TCLSH_PROG}`
for dir in $searchdirs ; do
   dirs="${dir}/Img*"
   for i in $dirs ; do
       if test -d "$i" -a -f "$i/pkgIndex.tcl"; then
          IMGLIB=`cd $i; pwd`
       fi
   done
done
AC_ARG_WITH(imglib, [  --with-imglib=DIR          use img from DIR], IMGLIB=$withval,)
if test x$IMGLIB != x -a -d $IMGLIB; then
  AC_MSG_RESULT([using img library in $IMGLIB])
else
  AC_MSG_ERROR(Img library directory not found)
fi
AC_SUBST(IMGLIB)
])


                          


