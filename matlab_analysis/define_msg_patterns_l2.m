msg_pattern_l2=["InToConveyor #2"	"RobotController 2 #2"	"FeedRequest"	;
"RobotController 2 #2"	"InToConveyor #2"	"ACK"	;
"RobotController 2 #2"	"FeedLineRobot 2 #2"	"FeedCommand"	;
"InToConveyor #2"	"RobotController 1 #2"	"FeedRequest"	;
"RobotController 1 #2"	"InToConveyor #2"	"ACK"	;
"InFromConveyor #2"	"RobotController 3 #2"	"FeedPressRequest"	;
"RobotController 3 #2"	"InFromConveyor #2"	"ACK"	;
"UWICORE Press 1 #2"	"RobotController 4 #2"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 8–9 with lines 10–11.
"RobotController 4 #2"	"UWICORE Press 1 #2"	"ACK"	;
"UWICORE Press 1 #2"	"RobotController 3 #2"	"PressState"	;
"RobotController 3 #2"	"UWICORE Press 1 #2"	"ACK"	;
"RobotController 3 #2"	"FeedPressRobot 1 #2"	"FeedPressCommand"	;
"FeedPressRobot 1 #2"	"RobotController 3 #2"	"ACK"	;           %-----------%
"UWICORE Press 1 #2"	"RobotController 4 #2"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 14-15 with lines 16–17.
"RobotController 4 #2"	"UWICORE Press 1 #2"	"ACK"	;
"UWICORE Press 1 #2"	"RobotController 3 #2"	"PressState"	;
"RobotController 3 #2"	"UWICORE Press 1 #2"	"ACK"	;           %-----------%
"UWICORE Press 2 #2"	"RobotController 5 #2"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 18-19 with lines 20–21.
"RobotController 5 #2"	"UWICORE Press 2 #2"	"ACK"	;
"UWICORE Press 2 #2"	"RobotController 4 #2"	"PressState"	;
"RobotController 4 #2"	"UWICORE Press 2 #2"	"ACK"	;           %-----------%
"RobotController 4 #2"	"FeedPressRobot 2 #2"	"FeedPressCommand"	;
"FeedPressRobot 2 #2"	"RobotController 4 #2"	"ACK"	;
"UWICORE Press 2 #2"	"RobotController 5 #2"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 24-25 with lines 26–27.
"RobotController 5 #2"	"UWICORE Press 2 #2"	"ACK"	;
"UWICORE Press 2 #2"	"RobotController 4 #2"	"PressState"	;
"RobotController 4 #2"	"UWICORE Press 2 #2"	"ACK"	;           %-----------%
"UWICORE Press 3 #2"	"RobotController 6 #2"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 28-29 with lines 30–31.
"RobotController 6 #2"	"UWICORE Press 3 #2"	"ACK"	;
"UWICORE Press 3 #2"	"RobotController 5 #2"	"PressState"	;
"RobotController 5 #2"	"UWICORE Press 3 #2"	"ACK"	;           %-----------%
"RobotController 5 #2"	"FeedPressRobot 3 #2"	"FeedPressCommand"	;
"FeedPressRobot 3 #2"	"RobotController 5 #2"	"ACK"	;
"UWICORE Press 3 #2"	"RobotController 6 #2"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 4-35 with lines 36–37.
"RobotController 6 #2"	"UWICORE Press 3 #2"	"ACK"	;
"UWICORE Press 3 #2"	"RobotController 5 #2"	"PressState"	;
"RobotController 5 #2"	"UWICORE Press 3 #2"	"ACK"	;           %-----------%
"OutToConveyor #2"	"RobotController 6 #2"	"ConveyorState"	;
"RobotController 6 #2"	"OutToConveyor #2"	"ACK"	;
"RobotController 6 #2"	"FeedPressRobot 4 #2"	"FeedPressCommand"	;
"FeedPressRobot 4 #2"	"RobotController 6 #2"	"ACK"	;
"OutToConveyor #2"	"RobotController 6 #2"	"ConveyorState"	;
"RobotController 6 #2"	"OutToConveyor #2"	"ACK"	;
"OutToConveyor #2"	"RobotController 6 #2"	"ConveyorState"	;
"RobotController 6 #2"	"OutToConveyor #2"	"ACK"	;
"QualityNode #2"	"CameraController #2"	"SheetInQualityControlArea"	;
"CameraController #2"	"QualityNode #2"	"ACK"	;
"CameraController #2"	"QualityCamera #2"	"StartImageCapture"	;
"QualityCamera #2"	"CameraController #2"	"CameraData"	;
"CameraController #2"	"QualityCamera #2"	"ACK"	;
"QualityCamera #2"	"CameraController #2"	"CameraData"	;
];

msg_pattern_l2_end=["QualityNode #2"	"CameraController #2"	"SheetInQualityControlArea"	;
"CameraController #2"	"QualityNode #2"	"ACK"	;
"QualityCamera #2"	"CameraController #2"	"CameraData"	;
"CameraController #2"	"RobotController 7 #2"	"QualityResult"	;
"RobotController 7 #2"	"CameraController #2"	"ACK"	;
];

msg_pattern_l2_end_ok=["OutFromConveyor #2"	"StorageController - Out"	"SensorState"
];

msg_pattern_l2_end_fail=["RobotController 7 #2"	"FailLineRobot #2"	"RemoveProduct"	;
"FailLineRobot #2"	"RobotController 7 #2"	"ACK"	;
];
