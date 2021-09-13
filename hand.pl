:- module(hand,[finger_type/4]).

%finger type connection (P1, P2, P3, Type)
%P1,P2,P3 in [1;42]

finger_type(1, 2, 3, bpabc).
finger_type(4, 5, 6, oabc).
finger_type(5, 6, 7, obcd).
finger_type(8, 9, 10, oabc).
finger_type(9, 10, 11, obcd).
finger_type(12, 13, 14, oabc).
finger_type(13, 14, 15, obcd).
finger_type(16, 17, 18, oabc).
finger_type(17, 18, 19, obcd).

finger_type(2, 3, 21, bpprived).
finger_type(4, 7, 21, oprived).
finger_type(8, 11, 21, oprived).
finger_type(12, 15, 21, oprived).
finger_type(16, 19, 21, oprived).
finger_type(1, 2, 3, bppsgib1).
finger_type(2, 3, 21, bppsgib2).
finger_type(5, 4, 6, o2sgib1).
finger_type(6, 5, 7, o2sgib2).
finger_type(7, 6, 21, o2sgib3).
finger_type(9, 8, 10, o3sgib1).
finger_type(10, 9, 11, o3sgib2).
finger_type(11, 10, 21, o3sgib3).
finger_type(13, 12, 14, o4sgib1).
finger_type(14, 13, 15, o4sgib2).
finger_type(15, 14, 21, o4sgib3).
finger_type(17, 16, 18, o5sgib1),
finger_type(18, 17, 19, o5sgib2).
finger_type(19, 18, 21, o5sgib3).