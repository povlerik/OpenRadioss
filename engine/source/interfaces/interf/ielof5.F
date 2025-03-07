Copyright>        OpenRadioss
Copyright>        Copyright (C) 1986-2023 Altair Engineering Inc.
Copyright>
Copyright>        This program is free software: you can redistribute it and/or modify
Copyright>        it under the terms of the GNU Affero General Public License as published by
Copyright>        the Free Software Foundation, either version 3 of the License, or
Copyright>        (at your option) any later version.
Copyright>
Copyright>        This program is distributed in the hope that it will be useful,
Copyright>        but WITHOUT ANY WARRANTY; without even the implied warranty of
Copyright>        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
Copyright>        GNU Affero General Public License for more details.
Copyright>
Copyright>        You should have received a copy of the GNU Affero General Public License
Copyright>        along with this program.  If not, see <https://www.gnu.org/licenses/>.
Copyright>
Copyright>
Copyright>        Commercial Alternative: Altair Radioss Software
Copyright>
Copyright>        As an alternative to this open-source version, Altair also offers Altair Radioss
Copyright>        software under a commercial license.  Contact Altair to discuss further if the
Copyright>        commercial version may interest you: https://www.altair.com/radioss/.
Chd|====================================================================
Chd|  IELOF5                        source/interfaces/interf/ielof5.F
Chd|-- called by -----------
Chd|        IELOF2                        source/interfaces/interf/ielof2.F
Chd|-- calls ---------------
Chd|====================================================================
      SUBROUTINE IELOF5(
     1 IRECT ,STF   ,NRT   ,IXC   ,NSV   ,
     2 NEL   )
C-----------------------------------------------
C   I m p l i c i t   T y p e s
C-----------------------------------------------
#include      "implicit_f.inc"
#include      "comlock.inc"
C-----------------------------------------------
C   C o m m o n   B l o c k s
C-----------------------------------------------
#include      "param_c.inc"
C-----------------------------------------------
C   D u m m y   A r g u m e n t s
C-----------------------------------------------
      INTEGER NRT, NEL
      INTEGER IRECT(4,*), IXC(NIXC,*), NSV(*)
C     REAL
      my_real
     .   STF(*)
C-----------------------------------------------
C   L o c a l   V a r i a b l e s
C-----------------------------------------------
      INTEGER I, IXS, IYS, J, K, N2, N1, JJ, LL,
     .        IY(4),IX(4)
C-----------------------------------------------
#include "sync_dir.inc"
C-----------------------------------------------
      DO 400 I=1,NRT
      IF(STF(I)==ZERO)GOTO 400
      IXS=0
      IYS=0
      DO 100 J=1,4
      IY(J)=IRECT(J,I)
      IX(J)=IXC(J+1,NEL)
      IYS=IYS+IY(J)
      IXS=IXS+IX(J)
  100 CONTINUE
C----------------------------------------------
C  ELIMINATION SI SOMME DES NUMEROS DE NOEUDS #
C----------------------------------------------
      IF(IXS/=IYS)GOTO 400
C
      DO 200 J=1,4
      DO 150 K=1,4
      IF(IX(J)==IY(K))GOTO 200
  150 CONTINUE
      GOTO 400
  200 CONTINUE
#include "lockon.inc"
       STF(I)=0.
#include "lockoff.inc"
      RETURN
C
  400 CONTINUE
C
      RETURN
      END
