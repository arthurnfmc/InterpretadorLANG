{-# OPTIONS_GHC -w #-}
module Frontend.Parser.Parser (impParser) where

import Frontend.Lexer.Lexer
import Syntax.Syntax
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,540) ([0,0,0,0,0,0,0,0,0,0,0,16,0,64,0,0,0,0,0,0,0,1024,0,0,0,0,16384,0,0,0,0,0,0,0,0,16,0,0,0,0,64,0,0,0,2056,0,0,0,2,0,0,0,0,16384,0,0,0,8192,64,0,0,512,0,0,0,15,0,96,0,0,0,1024,0,0,0,0,64,0,0,512,0,0,0,0,4096,0,0,3840,0,24576,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,64,0,0,0,16384,0,0,0,0,64,0,0,0,0,64,0,0,0,64,0,0,15,0,96,0,0,512,0,0,0,0,0,0,0,3840,0,24576,0,0,0,0,1,0,0,0,256,0,0,0,16384,0,0,0,0,128,0,0,0,0,0,0,0,0,128,0,0,0,32768,0,0,0,0,128,0,0,0,32768,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3840,0,24576,0,0,0,0,0,0,49152,57,16416,0,0,15,0,96,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,2560,0,0,0,1026,0,0,0,0,2560,0,0,0,0,16,0,0,0,16384,0,64512,32,1160,64,0,8444,34816,16388,0,64512,32,1160,64,0,8444,34816,16388,0,0,0,0,1,0,0,0,0,0,0,0,16384,0,0,8444,34816,24580,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,32192,81,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,64,0,8444,34816,16388,0,64512,32,1160,64,0,8444,34816,16388,0,0,0,0,9,0,0,32192,65,0,0,49664,16765,0,0,0,32192,321,0,0,0,0,1,0,0,0,16384,0,64512,32,1160,64,0,0,0,16384,0,0,15,0,96,0,8444,34816,16388,0,64512,32,1160,64,0,0,0,16384,0,0,0,0,64,0,0,0,4,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,2048,0,0,49152,16765,1,0,0,0,2056,0,0,0,0,1,0,0,0,256,0,0,0,0,0,0,0,32192,321,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,8444,34816,16388,0,64512,32,1160,64,0,8444,34816,16388,0,64512,32,1160,64,0,8444,34816,16388,0,64512,32,1160,64,0,8444,34816,16388,0,64512,32,1160,64,0,8444,34816,16388,0,64512,32,1160,64,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,64512,32,1160,64,0,0,32192,73,0,0,0,16384,0,0,0,28672,64,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8444,34816,16388,0,0,0,32768,8,0,0,32192,65,0,0,0,0,0,0,0,0,0,0,64512,32,1160,64,0,0,0,2056,0,64512,32,1160,64,0,0,0,0,0,0,49152,16765,0,0,0,4,0,0,0,49152,49533,0,0,0,31808,64,0,0,0,16384,0,0,0,16384,64,0,0,0,16480,0,0,0,28672,64,0,0,0,16504,0,0,0,31808,65,0,0,16384,16765,0,0,0,31744,64,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,64,0,0,0,16384,0,64512,32,1160,64,0,0,0,2056,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,16384,0,64512,32,1160,96,0,0,0,0,0,0,0,4096,0,0,0,0,2176,0,0,0,16384,0,0,0,32192,65,0,64512,32,1160,64,0,0,0,0,0,0,0,0,0,0,0,0,2176,0,0,0,0,0,0,0,0,0,0,0,0,512,8,0,0,0,0,0,0,0,16384,0,0,8444,34816,16388,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,2176,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2176,0,0,0,0,1,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","ProgramStart","Program","DataDecl","FArgs","RetValsStart","RetVals","CodeBlock","StmtList","Stmt","MultAtrib","MultAtrib1","IdAtrib","Id","RegistS","Regist","FuncReturns","Ids","NewDecl","PTy","ArrayTy","Exps","Exps1","Exp","floatNum","num","char","'true'","'false'","'null'","'Int'","'Char'","'Bool'","'Float'","'data'","'new'","'read'","'print'","'if'","'then'","'else'","'return'","'iterate'","'skip'","'&&'","'=='","'!='","'::'","'+'","'-'","'*'","'/'","'%'","'!'","'<'","'>'","'('","')'","'{'","'}'","'['","']'","';'","'='","':'","','","'.'","'@'","id","%eof"]
        bit_start = st Prelude.* 72
        bit_end = (st Prelude.+ 1) Prelude.* 72
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..71]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_2
action_0 _ = happyReduce_4

action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (37) = happyShift action_5
action_2 (71) = happyShift action_6
action_2 (16) = happyGoto action_4
action_2 _ = happyReduce_1

action_3 (72) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (59) = happyShift action_8
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (71) = happyShift action_6
action_5 (16) = happyGoto action_7
action_5 _ = happyFail (happyExpListPerState 5)

action_6 _ = happyReduce_40

action_7 (61) = happyShift action_11
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (71) = happyShift action_6
action_8 (7) = happyGoto action_9
action_8 (16) = happyGoto action_10
action_8 _ = happyReduce_11

action_9 (60) = happyShift action_15
action_9 (68) = happyShift action_16
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (50) = happyShift action_14
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (71) = happyShift action_6
action_11 (6) = happyGoto action_12
action_11 (16) = happyGoto action_13
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (62) = happyShift action_30
action_12 (71) = happyShift action_6
action_12 (16) = happyGoto action_29
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (50) = happyShift action_28
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (33) = happyShift action_22
action_14 (34) = happyShift action_23
action_14 (35) = happyShift action_24
action_14 (36) = happyShift action_25
action_14 (70) = happyShift action_26
action_14 (71) = happyShift action_27
action_14 (22) = happyGoto action_20
action_14 (23) = happyGoto action_21
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (67) = happyShift action_19
action_15 (8) = happyGoto action_18
action_15 _ = happyReduce_13

action_16 (71) = happyShift action_6
action_16 (16) = happyGoto action_17
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (50) = happyShift action_45
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (61) = happyShift action_44
action_18 (10) = happyGoto action_43
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (33) = happyShift action_22
action_19 (34) = happyShift action_23
action_19 (35) = happyShift action_24
action_19 (36) = happyShift action_25
action_19 (70) = happyShift action_26
action_19 (71) = happyShift action_27
action_19 (9) = happyGoto action_41
action_19 (22) = happyGoto action_42
action_19 (23) = happyGoto action_21
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_10

action_21 _ = happyReduce_63

action_22 (63) = happyShift action_40
action_22 _ = happyReduce_58

action_23 (63) = happyShift action_39
action_23 _ = happyReduce_60

action_24 (63) = happyShift action_38
action_24 _ = happyReduce_59

action_25 (63) = happyShift action_37
action_25 _ = happyReduce_61

action_26 (71) = happyShift action_36
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (63) = happyShift action_35
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (33) = happyShift action_22
action_28 (34) = happyShift action_23
action_28 (35) = happyShift action_24
action_28 (36) = happyShift action_25
action_28 (70) = happyShift action_26
action_28 (71) = happyShift action_34
action_28 (16) = happyGoto action_32
action_28 (22) = happyGoto action_33
action_28 (23) = happyGoto action_21
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (50) = happyShift action_31
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_3

action_31 (33) = happyShift action_22
action_31 (34) = happyShift action_23
action_31 (35) = happyShift action_24
action_31 (36) = happyShift action_25
action_31 (70) = happyShift action_26
action_31 (71) = happyShift action_34
action_31 (16) = happyGoto action_56
action_31 (22) = happyGoto action_57
action_31 (23) = happyGoto action_21
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (65) = happyShift action_55
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (65) = happyShift action_54
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (63) = happyShift action_35
action_34 _ = happyReduce_40

action_35 (64) = happyShift action_53
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_62

action_37 (64) = happyShift action_52
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (64) = happyShift action_51
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (64) = happyShift action_50
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (64) = happyShift action_49
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (68) = happyShift action_48
action_41 _ = happyReduce_12

action_42 _ = happyReduce_15

action_43 _ = happyReduce_2

action_44 (11) = happyGoto action_47
action_44 _ = happyReduce_18

action_45 (33) = happyShift action_22
action_45 (34) = happyShift action_23
action_45 (35) = happyShift action_24
action_45 (36) = happyShift action_25
action_45 (70) = happyShift action_26
action_45 (71) = happyShift action_27
action_45 (22) = happyGoto action_46
action_45 (23) = happyGoto action_21
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_9

action_47 (39) = happyShift action_67
action_47 (40) = happyShift action_68
action_47 (41) = happyShift action_69
action_47 (44) = happyShift action_70
action_47 (45) = happyShift action_71
action_47 (46) = happyShift action_72
action_47 (62) = happyShift action_73
action_47 (71) = happyShift action_74
action_47 (12) = happyGoto action_61
action_47 (13) = happyGoto action_62
action_47 (15) = happyGoto action_63
action_47 (16) = happyGoto action_64
action_47 (17) = happyGoto action_65
action_47 (18) = happyGoto action_66
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (33) = happyShift action_22
action_48 (34) = happyShift action_23
action_48 (35) = happyShift action_24
action_48 (36) = happyShift action_25
action_48 (70) = happyShift action_26
action_48 (71) = happyShift action_27
action_48 (22) = happyGoto action_60
action_48 (23) = happyGoto action_21
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_65

action_50 _ = happyReduce_67

action_51 _ = happyReduce_66

action_52 _ = happyReduce_68

action_53 _ = happyReduce_64

action_54 _ = happyReduce_7

action_55 _ = happyReduce_8

action_56 (65) = happyShift action_59
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (65) = happyShift action_58
action_57 _ = happyFail (happyExpListPerState 57)

action_58 _ = happyReduce_5

action_59 _ = happyReduce_6

action_60 _ = happyReduce_14

action_61 _ = happyReduce_17

action_62 (66) = happyShift action_102
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (66) = happyShift action_100
action_63 (68) = happyShift action_101
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (50) = happyShift action_98
action_64 (59) = happyShift action_99
action_64 _ = happyReduce_45

action_65 (66) = happyShift action_96
action_65 (68) = happyShift action_97
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (69) = happyShift action_95
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (71) = happyShift action_6
action_67 (16) = happyGoto action_94
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (27) = happyShift action_80
action_68 (28) = happyShift action_81
action_68 (29) = happyShift action_82
action_68 (30) = happyShift action_83
action_68 (31) = happyShift action_84
action_68 (32) = happyShift action_85
action_68 (38) = happyShift action_86
action_68 (52) = happyShift action_87
action_68 (56) = happyShift action_88
action_68 (59) = happyShift action_89
action_68 (71) = happyShift action_6
action_68 (16) = happyGoto action_77
action_68 (17) = happyGoto action_78
action_68 (18) = happyGoto action_66
action_68 (26) = happyGoto action_93
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (27) = happyShift action_80
action_69 (28) = happyShift action_81
action_69 (29) = happyShift action_82
action_69 (30) = happyShift action_83
action_69 (31) = happyShift action_84
action_69 (32) = happyShift action_85
action_69 (38) = happyShift action_86
action_69 (52) = happyShift action_87
action_69 (56) = happyShift action_88
action_69 (59) = happyShift action_89
action_69 (71) = happyShift action_6
action_69 (16) = happyGoto action_77
action_69 (17) = happyGoto action_78
action_69 (18) = happyGoto action_66
action_69 (26) = happyGoto action_92
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (27) = happyShift action_80
action_70 (28) = happyShift action_81
action_70 (29) = happyShift action_82
action_70 (30) = happyShift action_83
action_70 (31) = happyShift action_84
action_70 (32) = happyShift action_85
action_70 (38) = happyShift action_86
action_70 (52) = happyShift action_87
action_70 (56) = happyShift action_88
action_70 (59) = happyShift action_89
action_70 (71) = happyShift action_6
action_70 (16) = happyGoto action_77
action_70 (17) = happyGoto action_78
action_70 (18) = happyGoto action_66
action_70 (25) = happyGoto action_90
action_70 (26) = happyGoto action_91
action_70 _ = happyReduce_74

action_71 (27) = happyShift action_80
action_71 (28) = happyShift action_81
action_71 (29) = happyShift action_82
action_71 (30) = happyShift action_83
action_71 (31) = happyShift action_84
action_71 (32) = happyShift action_85
action_71 (38) = happyShift action_86
action_71 (52) = happyShift action_87
action_71 (56) = happyShift action_88
action_71 (59) = happyShift action_89
action_71 (71) = happyShift action_6
action_71 (16) = happyGoto action_77
action_71 (17) = happyGoto action_78
action_71 (18) = happyGoto action_66
action_71 (26) = happyGoto action_79
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (65) = happyShift action_76
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_16

action_74 (63) = happyShift action_75
action_74 (66) = happyReduce_38
action_74 (68) = happyReduce_38
action_74 _ = happyReduce_40

action_75 (27) = happyShift action_80
action_75 (28) = happyShift action_81
action_75 (29) = happyShift action_82
action_75 (30) = happyShift action_83
action_75 (31) = happyShift action_84
action_75 (32) = happyShift action_85
action_75 (38) = happyShift action_86
action_75 (52) = happyShift action_87
action_75 (56) = happyShift action_88
action_75 (59) = happyShift action_89
action_75 (70) = happyShift action_144
action_75 (71) = happyShift action_6
action_75 (16) = happyGoto action_77
action_75 (17) = happyGoto action_78
action_75 (18) = happyGoto action_66
action_75 (24) = happyGoto action_142
action_75 (26) = happyGoto action_143
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_19

action_77 (59) = happyShift action_141
action_77 (69) = happyReduce_45
action_77 _ = happyReduce_81

action_78 _ = happyReduce_96

action_79 (47) = happyShift action_117
action_79 (48) = happyShift action_118
action_79 (49) = happyShift action_119
action_79 (51) = happyShift action_120
action_79 (52) = happyShift action_121
action_79 (53) = happyShift action_122
action_79 (54) = happyShift action_123
action_79 (55) = happyShift action_124
action_79 (57) = happyShift action_125
action_79 (61) = happyShift action_44
action_79 (63) = happyShift action_126
action_79 (10) = happyGoto action_140
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_76

action_81 _ = happyReduce_75

action_82 _ = happyReduce_77

action_83 _ = happyReduce_78

action_84 _ = happyReduce_79

action_85 _ = happyReduce_80

action_86 (33) = happyShift action_135
action_86 (34) = happyShift action_136
action_86 (35) = happyShift action_137
action_86 (36) = happyShift action_138
action_86 (71) = happyShift action_139
action_86 (21) = happyGoto action_134
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (27) = happyShift action_80
action_87 (28) = happyShift action_81
action_87 (29) = happyShift action_82
action_87 (30) = happyShift action_83
action_87 (31) = happyShift action_84
action_87 (32) = happyShift action_85
action_87 (38) = happyShift action_86
action_87 (52) = happyShift action_87
action_87 (56) = happyShift action_88
action_87 (59) = happyShift action_89
action_87 (71) = happyShift action_6
action_87 (16) = happyGoto action_77
action_87 (17) = happyGoto action_78
action_87 (18) = happyGoto action_66
action_87 (26) = happyGoto action_133
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (27) = happyShift action_80
action_88 (28) = happyShift action_81
action_88 (29) = happyShift action_82
action_88 (30) = happyShift action_83
action_88 (31) = happyShift action_84
action_88 (32) = happyShift action_85
action_88 (38) = happyShift action_86
action_88 (52) = happyShift action_87
action_88 (56) = happyShift action_88
action_88 (59) = happyShift action_89
action_88 (71) = happyShift action_6
action_88 (16) = happyGoto action_77
action_88 (17) = happyGoto action_78
action_88 (18) = happyGoto action_66
action_88 (26) = happyGoto action_132
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (27) = happyShift action_80
action_89 (28) = happyShift action_81
action_89 (29) = happyShift action_82
action_89 (30) = happyShift action_83
action_89 (31) = happyShift action_84
action_89 (32) = happyShift action_85
action_89 (38) = happyShift action_86
action_89 (52) = happyShift action_87
action_89 (56) = happyShift action_88
action_89 (59) = happyShift action_89
action_89 (71) = happyShift action_6
action_89 (16) = happyGoto action_77
action_89 (17) = happyGoto action_78
action_89 (18) = happyGoto action_66
action_89 (26) = happyGoto action_131
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (65) = happyShift action_129
action_90 (68) = happyShift action_130
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (47) = happyShift action_117
action_91 (48) = happyShift action_118
action_91 (49) = happyShift action_119
action_91 (51) = happyShift action_120
action_91 (52) = happyShift action_121
action_91 (53) = happyShift action_122
action_91 (54) = happyShift action_123
action_91 (55) = happyShift action_124
action_91 (57) = happyShift action_125
action_91 (63) = happyShift action_126
action_91 _ = happyReduce_73

action_92 (42) = happyShift action_128
action_92 (47) = happyShift action_117
action_92 (48) = happyShift action_118
action_92 (49) = happyShift action_119
action_92 (51) = happyShift action_120
action_92 (52) = happyShift action_121
action_92 (53) = happyShift action_122
action_92 (54) = happyShift action_123
action_92 (55) = happyShift action_124
action_92 (57) = happyShift action_125
action_92 (63) = happyShift action_126
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (47) = happyShift action_117
action_93 (48) = happyShift action_118
action_93 (49) = happyShift action_119
action_93 (51) = happyShift action_120
action_93 (52) = happyShift action_121
action_93 (53) = happyShift action_122
action_93 (54) = happyShift action_123
action_93 (55) = happyShift action_124
action_93 (57) = happyShift action_125
action_93 (63) = happyShift action_126
action_93 (65) = happyShift action_127
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (65) = happyShift action_116
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (71) = happyShift action_115
action_95 (16) = happyGoto action_114
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (27) = happyShift action_80
action_96 (28) = happyShift action_81
action_96 (29) = happyShift action_82
action_96 (30) = happyShift action_83
action_96 (31) = happyShift action_84
action_96 (32) = happyShift action_85
action_96 (38) = happyShift action_86
action_96 (52) = happyShift action_87
action_96 (56) = happyShift action_88
action_96 (59) = happyShift action_89
action_96 (71) = happyShift action_6
action_96 (16) = happyGoto action_77
action_96 (17) = happyGoto action_78
action_96 (18) = happyGoto action_66
action_96 (26) = happyGoto action_113
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (71) = happyShift action_74
action_97 (14) = happyGoto action_112
action_97 (15) = happyGoto action_105
action_97 (16) = happyGoto action_106
action_97 (17) = happyGoto action_107
action_97 (18) = happyGoto action_66
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (33) = happyShift action_22
action_98 (34) = happyShift action_23
action_98 (35) = happyShift action_24
action_98 (36) = happyShift action_25
action_98 (70) = happyShift action_26
action_98 (71) = happyShift action_34
action_98 (16) = happyGoto action_110
action_98 (22) = happyGoto action_111
action_98 (23) = happyGoto action_21
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (27) = happyShift action_80
action_99 (28) = happyShift action_81
action_99 (29) = happyShift action_82
action_99 (30) = happyShift action_83
action_99 (31) = happyShift action_84
action_99 (32) = happyShift action_85
action_99 (38) = happyShift action_86
action_99 (52) = happyShift action_87
action_99 (56) = happyShift action_88
action_99 (59) = happyShift action_89
action_99 (71) = happyShift action_6
action_99 (16) = happyGoto action_77
action_99 (17) = happyGoto action_78
action_99 (18) = happyGoto action_66
action_99 (25) = happyGoto action_109
action_99 (26) = happyGoto action_91
action_99 _ = happyReduce_74

action_100 (27) = happyShift action_80
action_100 (28) = happyShift action_81
action_100 (29) = happyShift action_82
action_100 (30) = happyShift action_83
action_100 (31) = happyShift action_84
action_100 (32) = happyShift action_85
action_100 (38) = happyShift action_86
action_100 (52) = happyShift action_87
action_100 (56) = happyShift action_88
action_100 (59) = happyShift action_89
action_100 (71) = happyShift action_6
action_100 (16) = happyGoto action_77
action_100 (17) = happyGoto action_78
action_100 (18) = happyGoto action_66
action_100 (26) = happyGoto action_108
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (71) = happyShift action_74
action_101 (14) = happyGoto action_104
action_101 (15) = happyGoto action_105
action_101 (16) = happyGoto action_106
action_101 (17) = happyGoto action_107
action_101 (18) = happyGoto action_66
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (71) = happyShift action_6
action_102 (16) = happyGoto action_103
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (59) = happyShift action_170
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_32

action_105 (68) = happyShift action_169
action_105 _ = happyReduce_37

action_106 _ = happyReduce_45

action_107 (68) = happyShift action_168
action_107 _ = happyReduce_36

action_108 (47) = happyShift action_117
action_108 (48) = happyShift action_118
action_108 (49) = happyShift action_119
action_108 (51) = happyShift action_120
action_108 (52) = happyShift action_121
action_108 (53) = happyShift action_122
action_108 (54) = happyShift action_123
action_108 (55) = happyShift action_124
action_108 (57) = happyShift action_125
action_108 (63) = happyShift action_126
action_108 (65) = happyShift action_167
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (60) = happyShift action_166
action_109 (68) = happyShift action_130
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (65) = happyShift action_165
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (65) = happyShift action_164
action_111 _ = happyFail (happyExpListPerState 111)

action_112 _ = happyReduce_33

action_113 (47) = happyShift action_117
action_113 (48) = happyShift action_118
action_113 (49) = happyShift action_119
action_113 (51) = happyShift action_120
action_113 (52) = happyShift action_121
action_113 (53) = happyShift action_122
action_113 (54) = happyShift action_123
action_113 (55) = happyShift action_124
action_113 (57) = happyShift action_125
action_113 (63) = happyShift action_126
action_113 (65) = happyShift action_163
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (69) = happyReduce_43
action_114 _ = happyReduce_41

action_115 (70) = happyShift action_162
action_115 _ = happyReduce_40

action_116 _ = happyReduce_28

action_117 (27) = happyShift action_80
action_117 (28) = happyShift action_81
action_117 (29) = happyShift action_82
action_117 (30) = happyShift action_83
action_117 (31) = happyShift action_84
action_117 (32) = happyShift action_85
action_117 (38) = happyShift action_86
action_117 (52) = happyShift action_87
action_117 (56) = happyShift action_88
action_117 (59) = happyShift action_89
action_117 (71) = happyShift action_6
action_117 (16) = happyGoto action_77
action_117 (17) = happyGoto action_78
action_117 (18) = happyGoto action_66
action_117 (26) = happyGoto action_161
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (27) = happyShift action_80
action_118 (28) = happyShift action_81
action_118 (29) = happyShift action_82
action_118 (30) = happyShift action_83
action_118 (31) = happyShift action_84
action_118 (32) = happyShift action_85
action_118 (38) = happyShift action_86
action_118 (52) = happyShift action_87
action_118 (56) = happyShift action_88
action_118 (59) = happyShift action_89
action_118 (71) = happyShift action_6
action_118 (16) = happyGoto action_77
action_118 (17) = happyGoto action_78
action_118 (18) = happyGoto action_66
action_118 (26) = happyGoto action_160
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (27) = happyShift action_80
action_119 (28) = happyShift action_81
action_119 (29) = happyShift action_82
action_119 (30) = happyShift action_83
action_119 (31) = happyShift action_84
action_119 (32) = happyShift action_85
action_119 (38) = happyShift action_86
action_119 (52) = happyShift action_87
action_119 (56) = happyShift action_88
action_119 (59) = happyShift action_89
action_119 (71) = happyShift action_6
action_119 (16) = happyGoto action_77
action_119 (17) = happyGoto action_78
action_119 (18) = happyGoto action_66
action_119 (26) = happyGoto action_159
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (27) = happyShift action_80
action_120 (28) = happyShift action_81
action_120 (29) = happyShift action_82
action_120 (30) = happyShift action_83
action_120 (31) = happyShift action_84
action_120 (32) = happyShift action_85
action_120 (38) = happyShift action_86
action_120 (52) = happyShift action_87
action_120 (56) = happyShift action_88
action_120 (59) = happyShift action_89
action_120 (71) = happyShift action_6
action_120 (16) = happyGoto action_77
action_120 (17) = happyGoto action_78
action_120 (18) = happyGoto action_66
action_120 (26) = happyGoto action_158
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (27) = happyShift action_80
action_121 (28) = happyShift action_81
action_121 (29) = happyShift action_82
action_121 (30) = happyShift action_83
action_121 (31) = happyShift action_84
action_121 (32) = happyShift action_85
action_121 (38) = happyShift action_86
action_121 (52) = happyShift action_87
action_121 (56) = happyShift action_88
action_121 (59) = happyShift action_89
action_121 (71) = happyShift action_6
action_121 (16) = happyGoto action_77
action_121 (17) = happyGoto action_78
action_121 (18) = happyGoto action_66
action_121 (26) = happyGoto action_157
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (27) = happyShift action_80
action_122 (28) = happyShift action_81
action_122 (29) = happyShift action_82
action_122 (30) = happyShift action_83
action_122 (31) = happyShift action_84
action_122 (32) = happyShift action_85
action_122 (38) = happyShift action_86
action_122 (52) = happyShift action_87
action_122 (56) = happyShift action_88
action_122 (59) = happyShift action_89
action_122 (71) = happyShift action_6
action_122 (16) = happyGoto action_77
action_122 (17) = happyGoto action_78
action_122 (18) = happyGoto action_66
action_122 (26) = happyGoto action_156
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (27) = happyShift action_80
action_123 (28) = happyShift action_81
action_123 (29) = happyShift action_82
action_123 (30) = happyShift action_83
action_123 (31) = happyShift action_84
action_123 (32) = happyShift action_85
action_123 (38) = happyShift action_86
action_123 (52) = happyShift action_87
action_123 (56) = happyShift action_88
action_123 (59) = happyShift action_89
action_123 (71) = happyShift action_6
action_123 (16) = happyGoto action_77
action_123 (17) = happyGoto action_78
action_123 (18) = happyGoto action_66
action_123 (26) = happyGoto action_155
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (27) = happyShift action_80
action_124 (28) = happyShift action_81
action_124 (29) = happyShift action_82
action_124 (30) = happyShift action_83
action_124 (31) = happyShift action_84
action_124 (32) = happyShift action_85
action_124 (38) = happyShift action_86
action_124 (52) = happyShift action_87
action_124 (56) = happyShift action_88
action_124 (59) = happyShift action_89
action_124 (71) = happyShift action_6
action_124 (16) = happyGoto action_77
action_124 (17) = happyGoto action_78
action_124 (18) = happyGoto action_66
action_124 (26) = happyGoto action_154
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (27) = happyShift action_80
action_125 (28) = happyShift action_81
action_125 (29) = happyShift action_82
action_125 (30) = happyShift action_83
action_125 (31) = happyShift action_84
action_125 (32) = happyShift action_85
action_125 (38) = happyShift action_86
action_125 (52) = happyShift action_87
action_125 (56) = happyShift action_88
action_125 (59) = happyShift action_89
action_125 (71) = happyShift action_6
action_125 (16) = happyGoto action_77
action_125 (17) = happyGoto action_78
action_125 (18) = happyGoto action_66
action_125 (26) = happyGoto action_153
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (27) = happyShift action_80
action_126 (28) = happyShift action_81
action_126 (29) = happyShift action_82
action_126 (30) = happyShift action_83
action_126 (31) = happyShift action_84
action_126 (32) = happyShift action_85
action_126 (38) = happyShift action_86
action_126 (52) = happyShift action_87
action_126 (56) = happyShift action_88
action_126 (59) = happyShift action_89
action_126 (71) = happyShift action_6
action_126 (16) = happyGoto action_77
action_126 (17) = happyGoto action_78
action_126 (18) = happyGoto action_66
action_126 (26) = happyGoto action_152
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_27

action_128 (61) = happyShift action_44
action_128 (10) = happyGoto action_151
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_30

action_130 (27) = happyShift action_80
action_130 (28) = happyShift action_81
action_130 (29) = happyShift action_82
action_130 (30) = happyShift action_83
action_130 (31) = happyShift action_84
action_130 (32) = happyShift action_85
action_130 (38) = happyShift action_86
action_130 (52) = happyShift action_87
action_130 (56) = happyShift action_88
action_130 (59) = happyShift action_89
action_130 (71) = happyShift action_6
action_130 (16) = happyGoto action_77
action_130 (17) = happyGoto action_78
action_130 (18) = happyGoto action_66
action_130 (26) = happyGoto action_150
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (47) = happyShift action_117
action_131 (48) = happyShift action_118
action_131 (49) = happyShift action_119
action_131 (51) = happyShift action_120
action_131 (52) = happyShift action_121
action_131 (53) = happyShift action_122
action_131 (54) = happyShift action_123
action_131 (55) = happyShift action_124
action_131 (57) = happyShift action_125
action_131 (60) = happyShift action_149
action_131 (63) = happyShift action_126
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (63) = happyShift action_126
action_132 _ = happyReduce_94

action_133 (53) = happyShift action_122
action_133 (54) = happyShift action_123
action_133 (55) = happyShift action_124
action_133 (63) = happyShift action_126
action_133 _ = happyReduce_91

action_134 (63) = happyShift action_148
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_53

action_136 _ = happyReduce_55

action_137 _ = happyReduce_54

action_138 _ = happyReduce_56

action_139 _ = happyReduce_57

action_140 _ = happyReduce_29

action_141 (27) = happyShift action_80
action_141 (28) = happyShift action_81
action_141 (29) = happyShift action_82
action_141 (30) = happyShift action_83
action_141 (31) = happyShift action_84
action_141 (32) = happyShift action_85
action_141 (38) = happyShift action_86
action_141 (52) = happyShift action_87
action_141 (56) = happyShift action_88
action_141 (59) = happyShift action_89
action_141 (71) = happyShift action_6
action_141 (16) = happyGoto action_77
action_141 (17) = happyGoto action_78
action_141 (18) = happyGoto action_66
action_141 (25) = happyGoto action_147
action_141 (26) = happyGoto action_91
action_141 _ = happyReduce_74

action_142 (64) = happyShift action_145
action_142 (68) = happyShift action_146
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (47) = happyShift action_117
action_143 (48) = happyShift action_118
action_143 (49) = happyShift action_119
action_143 (51) = happyShift action_120
action_143 (52) = happyShift action_121
action_143 (53) = happyShift action_122
action_143 (54) = happyShift action_123
action_143 (55) = happyShift action_124
action_143 (57) = happyShift action_125
action_143 (63) = happyShift action_126
action_143 _ = happyReduce_70

action_144 _ = happyReduce_71

action_145 _ = happyReduce_39

action_146 (27) = happyShift action_80
action_146 (28) = happyShift action_81
action_146 (29) = happyShift action_82
action_146 (30) = happyShift action_83
action_146 (31) = happyShift action_84
action_146 (32) = happyShift action_85
action_146 (38) = happyShift action_86
action_146 (52) = happyShift action_87
action_146 (56) = happyShift action_88
action_146 (59) = happyShift action_89
action_146 (71) = happyShift action_6
action_146 (16) = happyGoto action_77
action_146 (17) = happyGoto action_78
action_146 (18) = happyGoto action_66
action_146 (26) = happyGoto action_181
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (60) = happyShift action_180
action_147 (68) = happyShift action_130
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (27) = happyShift action_80
action_148 (28) = happyShift action_81
action_148 (29) = happyShift action_82
action_148 (30) = happyShift action_83
action_148 (31) = happyShift action_84
action_148 (32) = happyShift action_85
action_148 (38) = happyShift action_86
action_148 (52) = happyShift action_87
action_148 (56) = happyShift action_88
action_148 (59) = happyShift action_89
action_148 (71) = happyShift action_6
action_148 (16) = happyGoto action_77
action_148 (17) = happyGoto action_78
action_148 (18) = happyGoto action_66
action_148 (25) = happyGoto action_179
action_148 (26) = happyGoto action_91
action_148 _ = happyReduce_74

action_149 _ = happyReduce_95

action_150 (47) = happyShift action_117
action_150 (48) = happyShift action_118
action_150 (49) = happyShift action_119
action_150 (51) = happyShift action_120
action_150 (52) = happyShift action_121
action_150 (53) = happyShift action_122
action_150 (54) = happyShift action_123
action_150 (55) = happyShift action_124
action_150 (57) = happyShift action_125
action_150 (63) = happyShift action_126
action_150 _ = happyReduce_72

action_151 (43) = happyShift action_178
action_151 _ = happyReduce_25

action_152 (47) = happyShift action_117
action_152 (48) = happyShift action_118
action_152 (49) = happyShift action_119
action_152 (51) = happyShift action_120
action_152 (52) = happyShift action_121
action_152 (53) = happyShift action_122
action_152 (54) = happyShift action_123
action_152 (55) = happyShift action_124
action_152 (57) = happyShift action_125
action_152 (63) = happyShift action_126
action_152 (64) = happyShift action_177
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (47) = happyShift action_117
action_153 (51) = happyShift action_120
action_153 (52) = happyShift action_121
action_153 (53) = happyShift action_122
action_153 (54) = happyShift action_123
action_153 (55) = happyShift action_124
action_153 (57) = happyFail []
action_153 (63) = happyShift action_126
action_153 _ = happyReduce_86

action_154 (63) = happyShift action_126
action_154 _ = happyReduce_89

action_155 (55) = happyShift action_124
action_155 (63) = happyShift action_126
action_155 _ = happyReduce_85

action_156 (54) = happyShift action_123
action_156 (55) = happyShift action_124
action_156 (63) = happyShift action_126
action_156 _ = happyReduce_83

action_157 (53) = happyShift action_122
action_157 (54) = happyShift action_123
action_157 (55) = happyShift action_124
action_157 (63) = happyShift action_126
action_157 _ = happyReduce_84

action_158 (52) = happyShift action_121
action_158 (53) = happyShift action_122
action_158 (54) = happyShift action_123
action_158 (55) = happyShift action_124
action_158 (63) = happyShift action_126
action_158 _ = happyReduce_82

action_159 (47) = happyShift action_117
action_159 (49) = happyFail []
action_159 (51) = happyShift action_120
action_159 (52) = happyShift action_121
action_159 (53) = happyShift action_122
action_159 (54) = happyShift action_123
action_159 (55) = happyShift action_124
action_159 (57) = happyShift action_125
action_159 (63) = happyShift action_126
action_159 _ = happyReduce_88

action_160 (47) = happyShift action_117
action_160 (48) = happyFail []
action_160 (49) = happyShift action_119
action_160 (51) = happyShift action_120
action_160 (52) = happyShift action_121
action_160 (53) = happyShift action_122
action_160 (54) = happyShift action_123
action_160 (55) = happyShift action_124
action_160 (57) = happyShift action_125
action_160 (63) = happyShift action_126
action_160 _ = happyReduce_87

action_161 (51) = happyShift action_120
action_161 (52) = happyShift action_121
action_161 (53) = happyShift action_122
action_161 (54) = happyShift action_123
action_161 (55) = happyShift action_124
action_161 (63) = happyShift action_126
action_161 _ = happyReduce_90

action_162 (63) = happyShift action_176
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_23

action_164 _ = happyReduce_22

action_165 _ = happyReduce_24

action_166 (57) = happyShift action_175
action_166 (19) = happyGoto action_174
action_166 _ = happyReduce_47

action_167 _ = happyReduce_20

action_168 (71) = happyShift action_74
action_168 (14) = happyGoto action_173
action_168 (15) = happyGoto action_105
action_168 (16) = happyGoto action_106
action_168 (17) = happyGoto action_107
action_168 (18) = happyGoto action_66
action_168 _ = happyFail (happyExpListPerState 168)

action_169 (71) = happyShift action_74
action_169 (14) = happyGoto action_172
action_169 (15) = happyGoto action_105
action_169 (16) = happyGoto action_106
action_169 (17) = happyGoto action_107
action_169 (18) = happyGoto action_66
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (27) = happyShift action_80
action_170 (28) = happyShift action_81
action_170 (29) = happyShift action_82
action_170 (30) = happyShift action_83
action_170 (31) = happyShift action_84
action_170 (32) = happyShift action_85
action_170 (38) = happyShift action_86
action_170 (52) = happyShift action_87
action_170 (56) = happyShift action_88
action_170 (59) = happyShift action_89
action_170 (71) = happyShift action_6
action_170 (16) = happyGoto action_77
action_170 (17) = happyGoto action_78
action_170 (18) = happyGoto action_66
action_170 (25) = happyGoto action_171
action_170 (26) = happyGoto action_91
action_170 _ = happyReduce_74

action_171 (60) = happyShift action_190
action_171 (68) = happyShift action_130
action_171 _ = happyFail (happyExpListPerState 171)

action_172 _ = happyReduce_34

action_173 _ = happyReduce_35

action_174 (65) = happyShift action_189
action_174 _ = happyFail (happyExpListPerState 174)

action_175 (71) = happyShift action_6
action_175 (16) = happyGoto action_186
action_175 (17) = happyGoto action_187
action_175 (18) = happyGoto action_66
action_175 (20) = happyGoto action_188
action_175 _ = happyReduce_52

action_176 (27) = happyShift action_80
action_176 (28) = happyShift action_81
action_176 (29) = happyShift action_82
action_176 (30) = happyShift action_83
action_176 (31) = happyShift action_84
action_176 (32) = happyShift action_85
action_176 (38) = happyShift action_86
action_176 (52) = happyShift action_87
action_176 (56) = happyShift action_88
action_176 (59) = happyShift action_89
action_176 (70) = happyShift action_144
action_176 (71) = happyShift action_6
action_176 (16) = happyGoto action_77
action_176 (17) = happyGoto action_78
action_176 (18) = happyGoto action_66
action_176 (24) = happyGoto action_185
action_176 (26) = happyGoto action_143
action_176 _ = happyFail (happyExpListPerState 176)

action_177 _ = happyReduce_92

action_178 (61) = happyShift action_44
action_178 (10) = happyGoto action_184
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (64) = happyShift action_183
action_179 (68) = happyShift action_130
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (63) = happyShift action_182
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (47) = happyShift action_117
action_181 (48) = happyShift action_118
action_181 (49) = happyShift action_119
action_181 (51) = happyShift action_120
action_181 (52) = happyShift action_121
action_181 (53) = happyShift action_122
action_181 (54) = happyShift action_123
action_181 (55) = happyShift action_124
action_181 (57) = happyShift action_125
action_181 (63) = happyShift action_126
action_181 _ = happyReduce_69

action_182 (27) = happyShift action_80
action_182 (28) = happyShift action_81
action_182 (29) = happyShift action_82
action_182 (30) = happyShift action_83
action_182 (31) = happyShift action_84
action_182 (32) = happyShift action_85
action_182 (38) = happyShift action_86
action_182 (52) = happyShift action_87
action_182 (56) = happyShift action_88
action_182 (59) = happyShift action_89
action_182 (71) = happyShift action_6
action_182 (16) = happyGoto action_77
action_182 (17) = happyGoto action_78
action_182 (18) = happyGoto action_66
action_182 (25) = happyGoto action_195
action_182 (26) = happyGoto action_91
action_182 _ = happyReduce_74

action_183 _ = happyReduce_97

action_184 _ = happyReduce_26

action_185 (64) = happyShift action_194
action_185 (68) = happyShift action_146
action_185 _ = happyFail (happyExpListPerState 185)

action_186 (69) = happyReduce_45
action_186 _ = happyReduce_50

action_187 _ = happyReduce_51

action_188 (58) = happyShift action_192
action_188 (68) = happyShift action_193
action_188 _ = happyFail (happyExpListPerState 188)

action_189 _ = happyReduce_31

action_190 (63) = happyShift action_191
action_190 _ = happyFail (happyExpListPerState 190)

action_191 (27) = happyShift action_80
action_191 (28) = happyShift action_81
action_191 (29) = happyShift action_82
action_191 (30) = happyShift action_83
action_191 (31) = happyShift action_84
action_191 (32) = happyShift action_85
action_191 (38) = happyShift action_86
action_191 (52) = happyShift action_87
action_191 (56) = happyShift action_88
action_191 (59) = happyShift action_89
action_191 (71) = happyShift action_6
action_191 (16) = happyGoto action_77
action_191 (17) = happyGoto action_78
action_191 (18) = happyGoto action_66
action_191 (25) = happyGoto action_199
action_191 (26) = happyGoto action_91
action_191 _ = happyReduce_74

action_192 _ = happyReduce_46

action_193 (71) = happyShift action_6
action_193 (16) = happyGoto action_197
action_193 (17) = happyGoto action_198
action_193 (18) = happyGoto action_66
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (69) = happyReduce_44
action_194 _ = happyReduce_42

action_195 (64) = happyShift action_196
action_195 (68) = happyShift action_130
action_195 _ = happyFail (happyExpListPerState 195)

action_196 _ = happyReduce_93

action_197 (69) = happyReduce_45
action_197 _ = happyReduce_48

action_198 _ = happyReduce_49

action_199 (64) = happyShift action_200
action_199 (68) = happyShift action_130
action_199 _ = happyFail (happyExpListPerState 199)

action_200 (65) = happyShift action_201
action_200 _ = happyFail (happyExpListPerState 200)

action_201 _ = happyReduce_21

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Program (reverse happy_var_1)
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happyReduce 7 5 happyReduction_2
happyReduction_2 ((HappyAbsSyn10  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ProgFunc (Function happy_var_2 (reverse happy_var_4) (reverse happy_var_6) happy_var_7) : happy_var_1
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 6 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ProgRegDec (RegisterDeclaration happy_var_3 (reverse happy_var_5)) : happy_var_1
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_0  5 happyReduction_4
happyReduction_4  =  HappyAbsSyn5
		 ([]
	)

happyReduce_5 = happyReduce 5 6 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_2, happy_var_4) : happy_var_1
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 6 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_2, CustomType happy_var_4) : happy_var_1
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 4 6 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ([(happy_var_1, happy_var_3)]
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 4 6 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ([(happy_var_1, CustomType happy_var_3)]
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 5 7 happyReduction_9
happyReduction_9 ((HappyAbsSyn22  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 ((happy_var_3, happy_var_5) : happy_var_1
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn7
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_0  7 happyReduction_11
happyReduction_11  =  HappyAbsSyn7
		 ([]
	)

happyReduce_12 = happySpecReduce_2  8 happyReduction_12
happyReduction_12 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  8 happyReduction_13
happyReduction_13  =  HappyAbsSyn8
		 ([]
	)

happyReduce_14 = happySpecReduce_3  9 happyReduction_14
happyReduction_14 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_3 : happy_var_1
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  9 happyReduction_15
happyReduction_15 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  10 happyReduction_16
happyReduction_16 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Block (reverse happy_var_2)
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  11 happyReduction_17
happyReduction_17 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_2 : happy_var_1
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_0  11 happyReduction_18
happyReduction_18  =  HappyAbsSyn11
		 ([]
	)

happyReduce_19 = happySpecReduce_2  12 happyReduction_19
happyReduction_19 _
	_
	 =  HappyAbsSyn12
		 (Skip
	)

happyReduce_20 = happyReduce 4 12 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 ((SimpleVar happy_var_1) := happy_var_3
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 10 12 happyReduction_21
happyReduction_21 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (happy_var_1 :=- (EFuncResults happy_var_3 (reverse happy_var_5) (reverse happy_var_8))
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 4 12 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Def happy_var_3 happy_var_1 Nothing
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 4 12 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 ((UserRegister happy_var_1) := happy_var_3
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 4 12 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (DefReg happy_var_3 happy_var_1
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 4 12 happyReduction_25
happyReduction_25 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (If happy_var_2 happy_var_4 (Block [Skip])
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 6 12 happyReduction_26
happyReduction_26 ((HappyAbsSyn10  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (If happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_3  12 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Print happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  12 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (SRead happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  12 happyReduction_29
happyReduction_29 (HappyAbsSyn10  happy_var_3)
	(HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Iterate happy_var_2 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  12 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Return (reverse happy_var_2)
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happyReduce 6 12 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (FunctionCall happy_var_1 (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_3  13 happyReduction_32
happyReduction_32 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 ((SimpleVar happy_var_1) : happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  13 happyReduction_33
happyReduction_33 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn13
		 ((UserRegister happy_var_1) : happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  14 happyReduction_34
happyReduction_34 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 ((SimpleVar happy_var_1) : happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  14 happyReduction_35
happyReduction_35 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn14
		 ((UserRegister happy_var_1) : happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  14 happyReduction_36
happyReduction_36 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn14
		 ([UserRegister happy_var_1]
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  14 happyReduction_37
happyReduction_37 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 ([SimpleVar happy_var_1]
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  15 happyReduction_38
happyReduction_38 (HappyTerminal ((ID happy_var_1)))
	 =  HappyAbsSyn15
		 ((Var happy_var_1)
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happyReduce 4 15 happyReduction_39
happyReduction_39 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal ((ID happy_var_1))) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 ((IndVar happy_var_1 (reverse happy_var_3))
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_1  16 happyReduction_40
happyReduction_40 (HappyTerminal ((ID happy_var_1)))
	 =  HappyAbsSyn16
		 ((Var happy_var_1)
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  17 happyReduction_41
happyReduction_41 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (((BaseVar happy_var_3) :.: happy_var_1)
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 7 17 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal ((ID happy_var_3))) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (((BaseVar (IndVar happy_var_3 (reverse happy_var_6))) :.: happy_var_1)
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_3  18 happyReduction_43
happyReduction_43 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 ((BaseVar happy_var_3) :.: happy_var_1
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 7 18 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal ((ID happy_var_3))) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 ((BaseVar (IndVar happy_var_3 (reverse happy_var_6))) :.: happy_var_1
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_1  18 happyReduction_45
happyReduction_45 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn18
		 (BaseVar happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  19 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (reverse happy_var_2
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_0  19 happyReduction_47
happyReduction_47  =  HappyAbsSyn19
		 ([]
	)

happyReduce_48 = happySpecReduce_3  20 happyReduction_48
happyReduction_48 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 ((PossVar happy_var_3) : happy_var_1
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  20 happyReduction_49
happyReduction_49 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 ((PossReg happy_var_3) : happy_var_1
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  20 happyReduction_50
happyReduction_50 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn20
		 ([PossVar happy_var_1]
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  20 happyReduction_51
happyReduction_51 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn20
		 ([PossReg happy_var_1]
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_0  20 happyReduction_52
happyReduction_52  =  HappyAbsSyn20
		 ([]
	)

happyReduce_53 = happySpecReduce_1  21 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn21
		 (TInt
	)

happyReduce_54 = happySpecReduce_1  21 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn21
		 (TBool
	)

happyReduce_55 = happySpecReduce_1  21 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn21
		 (TChar
	)

happyReduce_56 = happySpecReduce_1  21 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn21
		 (TFloat
	)

happyReduce_57 = happySpecReduce_1  21 happyReduction_57
happyReduction_57 (HappyTerminal ((ID happy_var_1)))
	 =  HappyAbsSyn21
		 (CustomType (Var happy_var_1)
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  22 happyReduction_58
happyReduction_58 _
	 =  HappyAbsSyn22
		 (TInt
	)

happyReduce_59 = happySpecReduce_1  22 happyReduction_59
happyReduction_59 _
	 =  HappyAbsSyn22
		 (TBool
	)

happyReduce_60 = happySpecReduce_1  22 happyReduction_60
happyReduction_60 _
	 =  HappyAbsSyn22
		 (TChar
	)

happyReduce_61 = happySpecReduce_1  22 happyReduction_61
happyReduction_61 _
	 =  HappyAbsSyn22
		 (TFloat
	)

happyReduce_62 = happySpecReduce_2  22 happyReduction_62
happyReduction_62 (HappyTerminal ((ID happy_var_2)))
	_
	 =  HappyAbsSyn22
		 (CustomType $ Var $ happy_var_2
	)
happyReduction_62 _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  22 happyReduction_63
happyReduction_63 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  23 happyReduction_64
happyReduction_64 _
	_
	(HappyTerminal ((ID happy_var_1)))
	 =  HappyAbsSyn23
		 (RegArray (Var happy_var_1)
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  23 happyReduction_65
happyReduction_65 _
	_
	_
	 =  HappyAbsSyn23
		 (Array TInt
	)

happyReduce_66 = happySpecReduce_3  23 happyReduction_66
happyReduction_66 _
	_
	_
	 =  HappyAbsSyn23
		 (Array TBool
	)

happyReduce_67 = happySpecReduce_3  23 happyReduction_67
happyReduction_67 _
	_
	_
	 =  HappyAbsSyn23
		 (Array TChar
	)

happyReduce_68 = happySpecReduce_3  23 happyReduction_68
happyReduction_68 _
	_
	_
	 =  HappyAbsSyn23
		 (Array TFloat
	)

happyReduce_69 = happySpecReduce_3  24 happyReduction_69
happyReduction_69 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_3 : happy_var_1
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  24 happyReduction_70
happyReduction_70 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn24
		 ([happy_var_1]
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  24 happyReduction_71
happyReduction_71 _
	 =  HappyAbsSyn24
		 ([]
	)

happyReduce_72 = happySpecReduce_3  25 happyReduction_72
happyReduction_72 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_3 : happy_var_1
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  25 happyReduction_73
happyReduction_73 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn25
		 ([happy_var_1]
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_0  25 happyReduction_74
happyReduction_74  =  HappyAbsSyn25
		 ([]
	)

happyReduce_75 = happySpecReduce_1  26 happyReduction_75
happyReduction_75 (HappyTerminal ((INT happy_var_1)))
	 =  HappyAbsSyn26
		 (EValue (EInt happy_var_1)
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  26 happyReduction_76
happyReduction_76 (HappyTerminal ((FLOAT happy_var_1)))
	 =  HappyAbsSyn26
		 (EValue (EFloat happy_var_1)
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  26 happyReduction_77
happyReduction_77 (HappyTerminal ((CHAR happy_var_1)))
	 =  HappyAbsSyn26
		 (EValue (EChar happy_var_1)
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  26 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn26
		 (EValue (EBool True)
	)

happyReduce_79 = happySpecReduce_1  26 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn26
		 (EValue (EBool False)
	)

happyReduce_80 = happySpecReduce_1  26 happyReduction_80
happyReduction_80 _
	 =  HappyAbsSyn26
		 (EValue ENull
	)

happyReduce_81 = happySpecReduce_1  26 happyReduction_81
happyReduction_81 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn26
		 (EVar happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  26 happyReduction_82
happyReduction_82 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :+: happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  26 happyReduction_83
happyReduction_83 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :*: happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_3  26 happyReduction_84
happyReduction_84 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :-: happy_var_3
	)
happyReduction_84 _ _ _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_3  26 happyReduction_85
happyReduction_85 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :/: happy_var_3
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  26 happyReduction_86
happyReduction_86 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :<: happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_3  26 happyReduction_87
happyReduction_87 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :==: happy_var_3
	)
happyReduction_87 _ _ _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_3  26 happyReduction_88
happyReduction_88 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :!=: happy_var_3
	)
happyReduction_88 _ _ _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  26 happyReduction_89
happyReduction_89 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :%: happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_3  26 happyReduction_90
happyReduction_90 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :&&: happy_var_3
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_2  26 happyReduction_91
happyReduction_91 (HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn26
		 (ENegative happy_var_2
	)
happyReduction_91 _ _  = notHappyAtAll 

happyReduce_92 = happyReduce 4 26 happyReduction_92
happyReduction_92 (_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (EIndexAccess happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_93 = happyReduce 7 26 happyReduction_93
happyReduction_93 (_ `HappyStk`
	(HappyAbsSyn25  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (EFuncResults happy_var_1 (reverse happy_var_3) (reverse happy_var_6)
	) `HappyStk` happyRest

happyReduce_94 = happySpecReduce_2  26 happyReduction_94
happyReduction_94 (HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn26
		 (ENot happy_var_2
	)
happyReduction_94 _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_3  26 happyReduction_95
happyReduction_95 _
	(HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn26
		 (happy_var_2
	)
happyReduction_95 _ _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  26 happyReduction_96
happyReduction_96 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn26
		 (EReg happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happyReduce 5 26 happyReduction_97
happyReduction_97 (_ `HappyStk`
	(HappyAbsSyn25  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (ENew happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 72 72 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	(FLOAT happy_dollar_dollar) -> cont 27;
	(INT happy_dollar_dollar) -> cont 28;
	(CHAR happy_dollar_dollar) -> cont 29;
	(BOOL True) -> cont 30;
	(BOOL False) -> cont 31;
	NULL -> cont 32;
	INTTYPE -> cont 33;
	CHARTYPE -> cont 34;
	BOOLTYPE -> cont 35;
	FLOATTYPE -> cont 36;
	DATA -> cont 37;
	NEW -> cont 38;
	READ -> cont 39;
	PRINT -> cont 40;
	IF -> cont 41;
	THEN -> cont 42;
	ELSE -> cont 43;
	RETURN -> cont 44;
	ITERATE -> cont 45;
	SKIP -> cont 46;
	AND -> cont 47;
	EQUAL -> cont 48;
	DIFTHAN -> cont 49;
	TYPEOF -> cont 50;
	PLUS -> cont 51;
	MINUS -> cont 52;
	MULT -> cont 53;
	DIV -> cont 54;
	MODULO -> cont 55;
	NOT -> cont 56;
	LESSTHAN -> cont 57;
	GREATERTHAN -> cont 58;
	OPENPARENS -> cont 59;
	CLOSEPARENS -> cont 60;
	OPENBRACES -> cont 61;
	CLOSEBRACES -> cont 62;
	OPENBRACKETS -> cont 63;
	CLOSEBRACKETS -> cont 64;
	SEMICOLON -> cont 65;
	ATTRIBUTION -> cont 66;
	COLON -> cont 67;
	COMMA -> cont 68;
	DOT -> cont 69;
	AT -> cont 70;
	(ID happy_dollar_dollar) -> cont 71;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 72 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parser tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError [] = error "Parse error!"
parseError (t : _) = error $ "Parse error " ++ (show t)


impParser :: String -> Program
impParser = parser . lexer
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
