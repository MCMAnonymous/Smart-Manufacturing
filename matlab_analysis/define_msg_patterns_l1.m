msg_pattern_l1=["InToConveyor #1"	"RobotController 1 #1"	"FeedRequest"	;
"RobotController 1 #1"	"InToConveyor #1"	"ACK"	;
"RobotController 1 #1"	"FeedLineRobot 2 #1"	"FeedCommand"	;
"InToConveyor #1"	"RobotController 2 #1"	"FeedRequest"	;
"RobotController 2 #1"	"InToConveyor #1"	"ACK"	;
"InFromConveyor #1"	"RobotController 3 #1"	"FeedPressRequest"	;
"RobotController 3 #1"	"InFromConveyor #1"	"ACK"	;
"UWICORE Press 1 #1"	"RobotController 3 #1"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 8–9 with lines 10–11. 
"RobotController 3 #1"	"UWICORE Press 1 #1"	"ACK"	;
"UWICORE Press 1 #1"	"RobotController 4 #1"	"PressState"	;   
"RobotController 4 #1"	"UWICORE Press 1 #1"	"ACK"	;
"RobotController 3 #1"	"FeedPressRobot 1 #1"	"FeedPressCommand"	;
"FeedPressRobot 1 #1"	"RobotController 3 #1"	"ACK"	;           %-----------%
"UWICORE Press 1 #1"	"RobotController 3 #1"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 14-15 with lines 16–17. 
"RobotController 3 #1"	"UWICORE Press 1 #1"	"ACK"	;
"UWICORE Press 1 #1"	"RobotController 4 #1"	"PressState"	;
"RobotController 4 #1"	"UWICORE Press 1 #1"	"ACK"	;           %-----------%
"UWICORE Press 2 #1"	"RobotController 5 #1"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 18-19 with lines 20–21.
"RobotController 5 #1"	"UWICORE Press 2 #1"	"ACK"	;
"UWICORE Press 2 #1"	"RobotController 4 #1"	"PressState"	;
"RobotController 4 #1"	"UWICORE Press 2 #1"	"ACK"	;           %-----------%
"RobotController 4 #1"	"FeedPressRobot 2 #1"	"FeedPressCommand"	;
"FeedPressRobot 2 #1"	"RobotController 4 #1"	"ACK"	;
"UWICORE Press 2 #1"	"RobotController 5 #1"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 24-25 with lines 26–27.
"RobotController 5 #1"	"UWICORE Press 2 #1"	"ACK"	;
"UWICORE Press 2 #1"	"RobotController 4 #1"	"PressState"	;
"RobotController 4 #1"	"UWICORE Press 2 #1"	"ACK"	;           %-----------%
"UWICORE Press 3 #1"	"RobotController 6 #1"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 28-29 with lines 30–31.
"RobotController 6 #1"	"UWICORE Press 3 #1"	"ACK"	;
"UWICORE Press 3 #1"	"RobotController 5 #1"	"PressState"	;
"RobotController 5 #1"	"UWICORE Press 3 #1"	"ACK"	;           %-----------%
"RobotController 5 #1"	"FeedPressRobot 3 #1"	"FeedPressCommand"	;
"FeedPressRobot 3 #1"	"RobotController 5 #1"	"ACK"	;
"UWICORE Press 3 #1"	"RobotController 6 #1"	"PressState"	;   % generated at the same timestamp. If this is not analyzed correctly, please swap lines 4-35 with lines 36–37.
"RobotController 6 #1"	"UWICORE Press 3 #1"	"ACK"	;
"UWICORE Press 3 #1"	"RobotController 5 #1"	"PressState"	;
"RobotController 5 #1"	"UWICORE Press 3 #1"	"ACK"	;           %-----------%
"OutToConveyor #1"	"RobotController 6 #1"	"ConveyorState"	;
"RobotController 6 #1"	"OutToConveyor #1"	"ACK"	;
"RobotController 6 #1"	"FeedPressRobot 4 #1"	"FeedPressCommand"	;
"FeedPressRobot 4 #1"	"RobotController 6 #1"	"ACK"	;
"OutToConveyor #1"	"RobotController 6 #1"	"ConveyorState"	;
"RobotController 6 #1"	"OutToConveyor #1"	"ACK"	;
"QualityNode #1"	"CameraController #1"	"SheetInQualityControlArea"	;
"CameraController #1"	"QualityNode #1"	"ACK"	;
"QualityNode #1"	"CameraController #1"	"SheetInQualityControlArea"	;
"CameraController #1"	"QualityNode #1"	"ACK"	;
"CameraController #1"	"QualityCamera #1"	"StartImageCapture"	;
"QualityCamera #1"	"CameraController #1"	"CameraData"	;
"CameraController #1"	"QualityCamera #1"	"ACK"	;
"QualityCamera #1"	"CameraController #1"	"CameraData"	;
];

msg_pattern_l1_end=["QualityNode #1"	"CameraController #1"	"SheetInQualityControlArea"	;
"CameraController #1"	"QualityNode #1"	"ACK"	;
"QualityCamera #1"	"CameraController #1"	"CameraData"	;
"CameraController #1"	"RobotController 7 #1"	"QualityResult"	;
"RobotController 7 #1"	"CameraController #1"	"ACK"	;
];

msg_pattern_l1_end_ok=["OutFromConveyor #1"	"StorageController - Out"	"SensorState"
];

msg_pattern_l1_end_fail=["RobotController 7 #1"	"FailLineRobot #1"	"RemoveProduct"	;
"FailLineRobot #1"	"RobotController 7 #1"	"ACK"	;
];


% msg_pattern_l1=["InToConveyor #1"	"RobotController 1 #1"	"FeedRequest"	;
% "RobotController 1 #1"	"InToConveyor #1"	"ACK"	;
% "RobotController 1 #1"	"FeedLineRobot 2 #1"	"FeedCommand"	;
% "InToConveyor #1"	"RobotController 2 #1"	"FeedRequest"	;
% "RobotController 2 #1"	"InToConveyor #1"	"ACK"	;
% "InFromConveyor #1"	"RobotController 3 #1"	"FeedPressRequest"	;
% "RobotController 3 #1"	"InFromConveyor #1"	"ACK"	;
% "UWICORE Press 1 #1"	"RobotController 3 #1"	"PressState"	;
% "RobotController 3 #1"	"UWICORE Press 1 #1"	"ACK"	;
% "UWICORE Press 1 #1"	"RobotController 4 #1"	"PressState"	;
% "RobotController 4 #1"	"UWICORE Press 1 #1"	"ACK"	;
% "RobotController 3 #1"	"FeedPressRobot 1 #1"	"FeedPressRequest"	;
% "FeedPressRobot 1 #1"	"RobotController 3 #1"	"ACK"	;
% "UWICORE Press 1 #1"	"RobotController 3 #1"	"PressState"	;
% "RobotController 3 #1"	"UWICORE Press 1 #1"	"ACK"	;
% "UWICORE Press 1 #1"	"RobotController 4 #1"	"PressState"	;
% "RobotController 4 #1"	"UWICORE Press 1 #1"	"ACK"	;
% "UWICORE Press 2 #1"	"RobotController 5 #1"	"PressState"	;
% "RobotController 5 #1"	"UWICORE Press 2 #1"	"ACK"	;
% "UWICORE Press 2 #1"	"RobotController 4 #1"	"PressState"	;
% "RobotController 4 #1"	"UWICORE Press 2 #1"	"ACK"	;
% "RobotController 4 #1"	"FeedPressRobot 2 #1"	"FeedPressRequest"	;
% "FeedPressRobot 2 #1"	"RobotController 4 #1"	"ACK"	;
% "UWICORE Press 2 #1"	"RobotController 5 #1"	"PressState"	;
% "RobotController 5 #1"	"UWICORE Press 2 #1"	"ACK"	;
% "UWICORE Press 2 #1"	"RobotController 4 #1"	"PressState"	;
% "RobotController 4 #1"	"UWICORE Press 2 #1"	"ACK"	;
% "UWICORE Press 3 #1"	"RobotController 6 #1"	"PressState"	;
% "RobotController 6 #1"	"UWICORE Press 3 #1"	"ACK"	;
% "UWICORE Press 3 #1"	"RobotController 5 #1"	"PressState"	;
% "RobotController 5 #1"	"UWICORE Press 3 #1"	"ACK"	;
% "RobotController 5 #1"	"FeedPressRobot 3 #1"	"FeedPressRequest"	;
% "FeedPressRobot 3 #1"	"RobotController 5 #1"	"ACK"	;
% "UWICORE Press 3 #1"	"RobotController 6 #1"	"PressState"	;
% "RobotController 6 #1"	"UWICORE Press 3 #1"	"ACK"	;
% "UWICORE Press 3 #1"	"RobotController 5 #1"	"PressState"	;
% "RobotController 5 #1"	"UWICORE Press 3 #1"	"ACK"	;
% "OutToConveyor #1"	"RobotController 6 #1"	"ConveyorState"	;
% "RobotController 6 #1"	"OutToConveyor #1"	"ACK"	;
% "RobotController 6 #1"	"FeedPressRobot 4 #1"	"FeedPressRequest"	;
% "FeedPressRobot 4 #1"	"RobotController 6 #1"	"ACK"	;
% "OutToConveyor #1"	"RobotController 6 #1"	"ConveyorState"	;
% "RobotController 6 #1"	"OutToConveyor #1"	"ACK"	;
% "QualityNode #1"	"CameraController #1"	"SheetInQualityControlArea"	;
% "CameraController #1"	"QualityNode #1"	"ACK"	;
% "CameraController #1"	"QualityCamera #1"	"StartImageCapture"	;
% "QualityCamera #1"	"CameraController #1"	"CameraData"	;
% "CameraController #1"	"QualityCamera #1"	"ACK"	;
% "QualityCamera #1"	"CameraController #1"	"CameraData"	;
% ];
