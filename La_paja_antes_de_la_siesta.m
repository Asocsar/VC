   c   l   e   a   r   
   c   l   o   s   e       a   l   l   
   c   l   c   
   
   N   B   I   N   S       =       2   0   ;   
   
   f   i   d       =       f   o   p   e   n   (   '   B   a   r   z   a   _   C   a   m   i   s   e   t   a   z   .   t   x   t   '   )   ;   
   t   l   i   n   e       =       f   g   e   t   l   (   f   i   d   )   ;   
   p   a   t   h   s       =       {   }   ;   
   i       =       1   ;   
   w   h   i   l   e       i   s   c   h   a   r   (   t   l   i   n   e   )   
                   i   f       i   s   c   h   a   r   (   t   l   i   n   e   )   
                                   p   a   t   h   s   {   i   }       =       t   l   i   n   e   ;   
                                   i       =       i       +       1   ;   
                   e   n   d   
                   t   l   i   n   e       =       f   g   e   t   l   (   f   i   d   )   ;   
   e   n   d   
   f   c   l   o   s   e   (   f   i   d   )   ;   
   
   n   u   m   _   p   a   t   h   s       =       l   e   n   g   t   h   (   p   a   t   h   s   )   ;   
   H   R   L       =       [   ]   ;   
   H   G   L       =       [   ]   ;   
   H   B   L       =       [   ]   ;   
   H   i   s   t   s       =       {   }   ;   %   z   e   r   o   s   (   n   u   m   _   p   a   t   h   s   ,   3   )   ;   
   
   c   o   l   o   r   s       =       [   "   r   e   d   "       ,       "   g   r   e   e   n   "       ,       "   b   l   u   e   "   ]   ;   
   c   r   o   p   s       =       {   }   ;   
   
   m   e   a   n   N       =       0   ;   
   m   e   a   n   M       =       0   ;   
   L   a   b   e   l   s       =       [   ]   ;   
   H   i   s   t   s       =       z   e   r   o   s   (   7   ,   2   *   N   B   I   N   S   )   ;   
   f   o   r       i       =       1   :   n   u   m   _   p   a   t   h   s   
                   A       =       i   m   r   e   a   d   (   p   a   t   h   s   {   i   }   )   ;   
                   i   m   s   h   o   w   (   A   )   ;   
                   C       =       g   e   t   r   e   c   t   ;   
                   C       =       A   (   C   (   2   )   :   C   (   2   )   +   C   (   4   )   ,       C   (   1   )   :   C   (   1   )   +   C   (   3   )   ,       :   )   ;   
                   c   r   o   p   s   {   i   }       =       n   o   r   m   C   o   l   o   r   s   (   C   )   ;   
                   [   n   C   ,       m   C   ]       =       s   i   z   e   (   C   (   :   ,   :   ,   1   )   )   ;   
                   m   e   a   n   N       =       m   e   a   n   N       +       n   C   ;   
                   m   e   a   n   M       =       m   e   a   n   M       +       m   C   ;   
                   L   a   b   e   l   s       =       [   L   a   b   e   l   s   ;       1   ]   ;   
                   
                   [   c   o   u   n   t   s   R   ,       b   i   n   s   ]       =       i   m   h   i   s   t   (   C   (   :   ,   :   ,   1   )   ,       N   B   I   N   S   )   ;   
                   %   c   o   u   n   t   s   R       =       d   o   u   b   l   e   (   c   o   u   n   t   s   R   )   ;   
                   %   c   o   u   n   t   s   R       =       H   i   s   t   N   o   r   m   (   c   o   u   n   t   s   R   )   ;   
                   [   c   o   u   n   t   s   G   ,       b   i   n   s   ]       =       i   m   h   i   s   t   (   C   (   :   ,   :   ,   2   )   ,       N   B   I   N   S   )   ;   
                   %   c   o   u   n   t   s   G       =       d   o   u   b   l   e   (   c   o   u   n   t   s   G   )   ;   
                   %   c   o   u   n   t   s   G       =       H   i   s   t   N   o   r   m   (   c   o   u   n   t   s   G   )   ;   
                   [   c   o   u   n   t   s   B   ,       b   i   n   s   ]       =       i   m   h   i   s   t   (   C   (   :   ,   :   ,   3   )   ,       N   B   I   N   S   )   ;   
                   %   c   o   u   n   t   s   B       =       d   o   u   b   l   e   (   c   o   u   n   t   s   B   )   ;   
                   %   c   o   u   n   t   s   B       =       H   i   s   t   N   o   r   m   (   c   o   u   n   t   s   B   )   ;   
                   
                   %   H   i   s   t   s   (   i   ,   1   ,   :   )       =       c   o   u   n   t   s   R   '   ;   
                   %   H   i   s   t   s   (   i   ,   2   ,   :   )       =       c   o   u   n   t   s   G   '   ;   
                   %   H   i   s   t   s   (   i   ,   3   ,   :   )       =       c   o   u   n   t   s   B   '   ;   
                   H   i   s   t   s   (   i   ,   :   )       =       H   i   s   t   N   o   r   m   (   [   c   o   u   n   t   s   R   '       c   o   u   n   t   s   B   '   ]   '   )   '   ;   
   e   n   d   
   
   
   M   d   l       =       f   i   t   c   s   v   m   (   H   i   s   t   s   ,   L   a   b   e   l   s   ,       '   K   e   r   n   e   l   F   u   n   c   t   i   o   n   '   ,       '   r   b   f   '   )   ;   
   
   m   e   a   n   N       =       m   e   a   n   N   /   n   u   m   _   p   a   t   h   s   ;   
   m   e   a   n   M       =       m   e   a   n   M   /   n   u   m   _   p   a   t   h   s   ;   
   
   
   
   
   
   
   %       R   E   A   D       A   L   L       P   A   T   H       I   M   A   G   E   S   
   f   i   d       =       f   o   p   e   n   (   '   A   l   l   _   i   m   a   g   e   s   .   t   x   t   '   )   ;   
   t   l   i   n   e       =       f   g   e   t   l   (   f   i   d   )   ;   
   p   a   t   h   s       =       {   }   ;   
   i       =       1   ;   
   w   h   i   l   e       i   s   c   h   a   r   (   t   l   i   n   e   )   
                   i   f       i   s   c   h   a   r   (   t   l   i   n   e   )   
                                   p   a   t   h   s   {   i   }       =       t   l   i   n   e   ;   
                                   i       =       i       +       1   ;   
                   e   n   d   
                   t   l   i   n   e       =       f   g   e   t   l   (   f   i   d   )   ;   
   e   n   d   
   f   c   l   o   s   e   (   f   i   d   )   ;   
   
   n   u   m   _   p   a   t   h   s       =       l   e   n   g   t   h   (   p   a   t   h   s   )   ;   
   
   
   %       C   O   M   P   U   T   E       S   L   I   D   I   N   G       W   I   N   D   O   W       H   I   S   T       F   O   R       A   L   L       I   M   A   G   E   S       A   N   D       C   L   A   S   S   I   F   I   Y   I   N   G   
   m       =       f   i   x   (   m   e   a   n   M   /   2   )   ;   
   n       =       f   i   x   (   m   e   a   n   N   /   2   )   ;   
   
   
   
   c   o   r   r   e   c   t       =       0   ;   
   p   r   e   c   i   s   i   o   n       =       0   ;   
   p   r   e   c   i   s   i   o   n   _   f   l       =       0   ;   
   
   f   o   r       i       =       1   :   n   u   m   _   p   a   t   h   s   
                   I       =       i   m   r   e   a   d   (   p   a   t   h   s   {   i   }   )   ;   
                   %   i   m   s   h   o   w   (   I   )   ;   
                   [   r       c   ]       =       s   i   z   e   (   I   (   :   ,   :   ,   1   )   )   ;   
                   
                   
                   s   a   l   t   o   s   _   c       =       8   ;   
                   s   a   l   t   o   s   _   r       =       8   ;   
                   c   s       =       f   i   x   (   c   /   s   a   l   t   o   s   _   c   )   ;   
                   r   s       =       f   i   x   (   r   /   s   a   l   t   o   s   _   r   )   ;   
                   R       =       0   ;   
                   s   c   o   r   e       =       0   ;   
                   f   o   r       k   1       =       1   :   c   s   :   c   
                                   f   o   r       k   2       =       1   :   r   s   :   r   
                                                   c   _   e   n   d       =       m   i   n   (   k   1   +   c   s   ,       c   )   ;   
                                                   r   _   e   n   d       =       m   i   n   (   k   2   +   r   s   ,       r   )   ;   
                                                   k   1   _   s   t   a   r   t       =       m   a   x   (   k   1   ,       1   )   ;   
                                                   k   2   _   s   t   a   r   t       =       m   a   x   (   k   2   ,       1   )   ;   
                                                   M       =       I   (   k   2   _   s   t   a   r   t   :   r   _   e   n   d   ,       k   1   _   s   t   a   r   t   :   c   _   e   n   d   ,       :   )   ;   
                                                   M       =       n   o   r   m   C   o   l   o   r   s   (   M   )   ;   
                                                   %   i   m   s   h   o   w   (   M   )   ;   
                                                   [   R   ,       b   i   n   s   ]       =       i   m   h   i   s   t   (   M   (   :   ,   :   ,   1   )   ,       N   B   I   N   S   )   ;   
                                                   %   R       =       d   o   u   b   l   e   (   R   )   ;   
                                                   %   R       =       H   i   s   t   N   o   r   m   (   R   )   ;   
                                                   [   G   ,       b   i   n   s   ]       =       i   m   h   i   s   t   (   M   (   :   ,   :   ,   2   )   ,       N   B   I   N   S   )   ;   
                                                   %   G       =       d   o   u   b   l   e   (   G   )   ;   
                                                   %   G       =       H   i   s   t   N   o   r   m   (   G   )   ;   
                                                   [   B   ,       b   i   n   s   ]       =       i   m   h   i   s   t   (   M   (   :   ,   :   ,   3   )   ,       N   B   I   N   S   )   ;   
                                                   %   B       =       d   o   u   b   l   e   (   B   )   ;   
                                                   %   B       =       H   i   s   t   N   o   r   m   (   B   )   ;   
                                                   X       =       H   i   s   t   N   o   r   m   (   [   R   '       B   '   ]   '   )   '   ;   
                                                   [   l   a   b   e   l   ,   s   c   o   r   e   _   a   u   x   ]       =       p   r   e   d   i   c   t   (   M   d   l   ,   X   )   ;   
                                                   i   f       s   c   o   r   e   _   a   u   x       >   =       0   
                                                                   s   c   o   r   e       =       s   c   o   r   e       +       1   ;   
                                                   e   n   d   
                                                   %   R       =       R       +       u   i   n   t   8   (   h   i   s   t   o   r   i   o   g   r   a   m   a   B   i   n   s   (   M   ,       N   B   I   N   S   ,       H   i   s   t   s   )   )   ;   
                                                   
                                   e   n   d   
                   e   n   d   
                   
                   i   f       s   c   o   r   e       >   =       1   2   
                                   d   i   s   p   (   p   a   t   h   s   {   i   }   )   ;   
                                   d   i   s   p   (   [   "   I   m   a   g   e       i   s       f   r   o   m       b   a   r   ?   a   "   ]   )   ;   
                                   %   d   i   s   p   (   [   R   ]   )   ;   
                                   
                                   i   f       i       <   =       3   6   
                                                   c   o   r   r   e   c   t       =       c   o   r   r   e   c   t       +       1   ;   
                                                   p   r   e   c   i   s   i   o   n       =       p   r   e   c   i   s   i   o   n       +       1   ;   
                                   e   n   d   
                   
                   e   l   s   e   i   f       i       <   =       3   6   
                                   p   r   e   c   i   s   i   o   n   _   f   l       =       p   r   e   c   i   s   i   o   n   _   f   l       +       1   ;   
   
                               
                   e   l   s   e   i   f       i       >   =       3   7   
                                   c   o   r   r   e   c   t       =       c   o   r   r   e   c   t       +       1   ;   
                               
                   e   n   d   
                   
   e   n   d   
   
   
   c   o   r   r   e   c   t       =       c   o   r   r   e   c   t   /   n   u   m   _   p   a   t   h   s   ;   
   d   i   s   p   (   [   "   A   c   c   u   r   a   c   y       o   f   "   ,       c   o   r   r   e   c   t   *   1   0   0   ,       "   %   "   ]   )   ;   
   d   i   s   p   (   [   "   P   r   e   c   i   s   i   o   n       o   f   "   ,       (   p   r   e   c   i   s   i   o   n   /   (   p   r   e   c   i   s   i   o   n   +   p   r   e   c   i   s   i   o   n   _   f   l   )   )   *   1   0   0   ,       "   %   "   ]   )   ;   
   
   f   u   n   c   t   i   o   n       R   e   s       =       h   i   s   t   o   r   i   o   g   r   a   m   a   B   i   n   s   (   I   m   a   g   e   _   d   a   t   a   ,       N   B   I   N   S   )   
   
   %   I   m   a   g   e   _   d   a   t   a       =       d   o   u   b   l   e   (   I   m   a   g   e   .   d   a   t   a   )   ;   
   %   f   i   g   u   r   e   ;   
   %   i   m   s   h   o   w   (   I   m   a   g   e   _   d   a   t   a   )   ;   
   
   
   R       =       I   m   a   g   e   _   d   a   t   a   (   :   ,       :   ,       1   )   ;   
   G       =       I   m   a   g   e   _   d   a   t   a   (   :   ,       :   ,       2   )   ;   
   B       =       I   m   a   g   e   _   d   a   t   a   (   :   ,       :   ,       3   )   ;   
   
   
   
   [   r   1   ,       r   2   ]       =       s   i   z   e   (   R   )   ;   
   [   g   1   ,       g   2   ]       =       s   i   z   e   (   G   )   ;   
   [   b   1   ,       b   2   ]       =       s   i   z   e   (   B   )   ;   
   
   
   I       =       c   a   t   (   3   ,   R   ,   G   ,   B   )   ;   
   
   %   I       =       n   o   r   m   C   o   l   o   r   s   (   I   )   ;   
   
   m   e   a   n       =       0   ;   
   t   h   r   e   s   h   o   l   d       =       0   .   2   3   ;   %   6   ;   %   0   .   2   ;   
   
   f   o   r       j       =       1   :   3   :   m   
                   d   i   s   t   1       =       0   ;   %   p   d   i   s   t   2   (   R   '   ,       H   i   s   t   s   {   j   }   (   :   ,   1   )   '   ,       '   c   h   i   s   q   '   )   ;   
                   d   i   s   t   2       =       0   ;   %   p   d   i   s   t   2   (   G   '   ,       H   i   s   t   s   {   j   +   1   }   (   :   ,   1   )   '   ,       '   c   h   i   s   q   '   )   ;   
                   d   i   s   t   3       =       0   ;   %   p   d   i   s   t   2   (   B   '   ,       H   i   s   t   s   {   j   +   2   }   (   :   ,   1   )   '   ,       '   c   h   i   s   q   '   )   ;   
                   
                   
                   m   e   a   n       =       m   e   a   n       +       (   d   i   s   t   1       <       t   h   r   e   s   h   o   l   d   )       &       (   d   i   s   t   2       <       t   h   r   e   s   h   o   l   d   )       &       (   d   i   s   t   3       <       t   h   r   e   s   h   o   l   d   )   ;   
                   
   e   n   d   
   
   
   R   e   s       =       m   e   a   n   ;   
   
   e   n   d   
   
   
   
   
   
   
