msg_pattern_l3=["InToConveyor #3"	"RobotController 2 #3"	"FeedRequest"	;
"RobotController 2 #3"	"InToConveyor #3"	"ACK"	;
"RobotController 2 #3"	"FeedLineRobot 2 #3"	"FeedCommand"	;
"InToConveyor #3"	"RobotController 1 #3"	"FeedRequest"	;
"RobotController 1 #3"	"InToConveyor #3"	"ACK"	;
"InFromConveyor #3"	"RobotController 3 #3"	"FeedPressRequest"	;
"RobotController 3 #3"	"InFromConveyor #3"	"ACK"	;
"UWICORE Press 1 #3"	"RobotController 4 #3"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 8–9 with lines 10–11.
"RobotController 4 #3"	"UWICORE Press 1 #3"	"ACK"	;
"UWICORE Press 1 #3"	"RobotController 3 #3"	"PressState"	;
"RobotController 3 #3"	"UWICORE Press 1 #3"	"ACK"	;
"RobotController 3 #3"	"FeedPressRobot 1 #3"	"FeedPressCommand"	;
"FeedPressRobot 1 #3"	"RobotController 3 #3"	"ACK"	;           %-----------%
"UWICORE Press 1 #3"	"RobotController 4 #3"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 14-15 with lines 16–17.
"RobotController 4 #3"	"UWICORE Press 1 #3"	"ACK"	;
"UWICORE Press 1 #3"	"RobotController 3 #3"	"PressState"	;
"RobotController 3 #3"	"UWICORE Press 1 #3"	"ACK"	;           %-----------%
"UWICORE Press 2 #3"	"RobotController 5 #3"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 18-19 with lines 20–21.
"RobotController 5 #3"	"UWICORE Press 2 #3"	"ACK"	;
"UWICORE Press 2 #3"	"RobotController 4 #3"	"PressState"	;
"RobotController 4 #3"	"UWICORE Press 2 #3"	"ACK"	;           %-----------%
"RobotController 4 #3"	"FeedPressRobot 2 #3"	"FeedPressCommand"	;
"FeedPressRobot 2 #3"	"RobotController 4 #3"	"ACK"	;
"UWICORE Press 2 #3"	"RobotController 5 #3"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 24-25 with lines 26–27.
"RobotController 5 #3"	"UWICORE Press 2 #3"	"ACK"	;
"UWICORE Press 2 #3"	"RobotController 4 #3"	"PressState"	;
"RobotController 4 #3"	"UWICORE Press 2 #3"	"ACK"	;           %-----------%
"UWICORE Press 3 #3"	"RobotController 5 #3"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 28-29 with lines 30–31.
"RobotController 5 #3"	"UWICORE Press 3 #3"	"ACK"	;
"UWICORE Press 3 #3"	"RobotController 6 #3"	"PressState"	;
"RobotController 6 #3"	"UWICORE Press 3 #3"	"ACK"	;           %-----------%
"RobotController 5 #3"	"FeedPressRobot 3 #3"	"FeedPressCommand"	;
"FeedPressRobot 3 #3"	"RobotController 5 #3"	"ACK"	;
"UWICORE Press 3 #3"	"RobotController 5 #3"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 4-35 with lines 36–37.
"RobotController 5 #3"	"UWICORE Press 3 #3"	"ACK"	;
"UWICORE Press 3 #3"	"RobotController 6 #3"	"PressState"	;
"RobotController 6 #3"	"UWICORE Press 3 #3"	"ACK"	;           %-----------%
"OutToConveyor #3"	"RobotController 6 #3"	"ConveyorState"	;
"RobotController 6 #3"	"OutToConveyor #3"	"ACK"	;
"RobotController 6 #3"	"FeedPressRobot 4 #3"	"FeedPressCommand"	;
"FeedPressRobot 4 #3"	"RobotController 6 #3"	"ACK"	;
"OutToConveyor #3"	"RobotController 6 #3"	"ConveyorState"	;
"RobotController 6 #3"	"OutToConveyor #3"	"ACK"	;
"OutToConveyor #3"	"RobotController 6 #3"	"ConveyorState"	;
"RobotController 6 #3"	"OutToConveyor #3"	"ACK"	;
"QualityNode #3"	"CameraController #3"	"SheetInQualityControlArea"	;
"CameraController #3"	"QualityNode #3"	"ACK"	;
"CameraController #3"	"QualityCamera #3"	"StartImageCapture"	;
"QualityCamera #3"	"CameraController #3"	"CameraData"	;
"CameraController #3"	"QualityCamera #3"	"ACK"	;
"QualityCamera #3"	"CameraController #3"	"CameraData"	;
];

msg_pattern_l3_end=["QualityNode #3"	"CameraController #3"	"SheetInQualityControlArea"	;
"CameraController #3"	"QualityNode #3"	"ACK"	;
"QualityCamera #3"	"CameraController #3"	"CameraData"	;
"CameraController #3"	"RobotController 7 #3"	"QualityResult"	;
"RobotController 7 #3"	"CameraController #3"	"ACK"	;
];

msg_pattern_l3_end_ok=["OutFromConveyor #3"	"StorageController - Out"	"SensorState"
];

msg_pattern_l3_end_fail=["RobotController 7 #3"	"FailLineRobot #3"	"RemoveProduct"	;
"FailLineRobot #3"	"RobotController 7 #3"	"ACK"	;
];
