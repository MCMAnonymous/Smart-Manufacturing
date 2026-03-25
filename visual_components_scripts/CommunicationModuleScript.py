from vcScript import *

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# Pay attention to the following points before using this Script:                                                                                                                                          #
#  -Use the ComTriggerSignal as a Trigger to send a certain msgType, the msgType depends on the value of ComTriggerSignal                                                     #
#  -Set the different msgTypes at the end of this Script                                                                                                                       #
#  -Set the pair of ComTriggerSignal value and the msgType to send in the last Dictionary 'conditionsDic'                                                                     #
#                                                                                                                                                                             #
# Format of the msg sent:                                                                                                                                                     #
# (SENDER ; RECEIVER ; MSG TYPE ; COMMUNICATION TYPE ; PERIOD ; MSG SIZE ; LATENCY ; RELIABILITY ; TECH USED ; MSG VALUE; ACK REQUIRED)                                       #
#                                                                                                                                                                             #
# Ejemplo:                                                                                                                                                                    #
#   SENDER: Mobile Robot Transport Controller                                                                                                                                 #
#   RECEIVER: Mobile Robot Resource                                                                                                                                           #
#   MSG TYPE: TransportCommand                                                                                                                                                #
#   COMMUNICATION TYPE: Periódica                                                                                                                                             #
#   PERIOD: 100 ms                                                                                                                                                            #
#   MSG SIZE: 64 bytes                                                                                                                                                        # 
#   LATENCY: 100 ms                                                                                                                                                           #
#   RELIABILITY: 99.9%                                                                                                                                                        #
#   TECH USED: WireLess                                                                                                                                                       #
#   MSG VALUE: [x,y,z,R,P,Y], (-1 = Null)                                                                                                                                     #
#  ACK REQUIRED: True                                                                                                                                                         #
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------#


comp = getComponent()
app = getApplication()
sim = getSimulation()


################################################################
## DEFAULT FUNCTIONS ###########################################
################################################################

def OnStart():
  #Call to Custom Functions
  # Get the list of components that will receive messages from the current component
  getPosibleDestinationMsgs()
  getTriggers()
  
  #Establishing required connections at the start of the simulation
  try:
    if comModuleScript not in comTriggerSignal.Connections:
      comTriggerSignal.Connections = comTriggerSignal.Connections + [comModuleScript] 
  except:
    pass
  
def OnRun():
  if False:     ##Enabled this condition for sending Periodic Msgs
    while True:
      ## UNCOMENT WHICH OPTION YOU NEED
      
      # Enable these lines to emulate periodic messages throughout the entire simulation
      '''
      sendMsg(periodicMsg)
      delayTime = float(periodicMsg['period'])/1000
      delay(delayTime)
      '''
      
      # Enable these lines to emulate the generation of periodic messages for a 
      # period of time after the occurrence of an event
      '''
      triggerCondition(lambda: startPeriodicMsgDetected())
      while comTriggerSignal != 'StopPeriodicMsg':
        sendMsg(periodicMsg)
        delayTime = float(periodicMsg['period'])/1000
        delay(delayTime)
      '''
  else:
    pass
 
def OnSignal(signal):
  global ackReceiver

  # This function is executed when ComTriggerSignal signal changes value
  # A new message is generated using 'sendMsg' method based on the value of ComTriggerSignal 
  if signal.Name != 'CommunicationModule':
    if signal.Value in conditionsDic.keys():  
      messageType = conditionsDic[signal.Value]
      sendMsg(messageType)
 
  else:
    # transmission of an ACK message if required as a reply of a received message
    signalList = signal.Value.split(';')
    ackRequerido = signalList[10] 
    destinatario = signalList[1]
    
    if ackRequerido == 'True' and destinatario == comp.Name:
      ackMsg['receiver'] = signal.Component.Name              
      sendMsg(ackMsg)
  
  
################################################################
## CUSTOM FUNCTIONS ############################################
################################################################

# write the message data in the CommunicationModule signal
def sendMsg(msgArg):
  msg = ''
  
  for key in msgKeys:
    value = msgArg.get(key)
    msg = msg + str(value) + ';'
  
  msg = msg[:-1]
  comModule.signal(msg)

# check the value of ComTriggerSignal. If ComTriggerSignal == StartPeriodicMsg
# the generation of periodic messages is enabled
def startPeriodicMsgDetected():
  trig = getTrigger()
  if trig.Value == 'StartPeriodicMsg':
    return True
  else:
    return False

def infoSignalDetected(signal): #Used to update values of msgTypes during Simulation
  #Change the Dictionary and the Key you want to update with the ComInfoSignal Value
  #defaultMsg['desiredKey'] = signal.Value
  #Example:
  #transportRequestMsg['receiver'] = signal.Value
  pass

def getPosibleDestinationMsgs():
  
  #TRANSPORT SOLUTIONS
  if comp.findBehavioursByType(VC_TRANSPORTNODE):
      #NOT SYSTEM CONTROLLERS
    #Uncomment destination below you need
    tNode = comp.findBehavioursByType(VC_TRANSPORTNODE)[0]
    tOutLinks = [n for n in tNode.TransportLinks if (n.Destination != tNode and (n.Implementer.IsSystem == False and n.Implementer.Icon != "UPM/pHumanTransportController"))]
    tInLinks  = [n for n in tNode.TransportLinks if (n.Destination == tNode and (n.Implementer.IsSystem == False and n.Implementer.Icon != "UPM/pHumanTransportController"))]
    tLinks = [n for n in tNode.TransportLinks if (n.Implementer.IsSystem == False and n.Implementer.Icon != "UPM/pHumanTransportController")]
    # Here you can choose between tOutLinks, tInLinks and all tLinks in the node
    destination = [tLinks[0].Implementer.Component]
    
      #SYSTEM CONTROLLERS
    #Uncomment destination below when you want connect to a ConveyorController or InterpolatingTransport
    tLinksSystem = [n for n in tNode.TransportLinks if n.Implementer.IsSystem == True]
    #destination = tLinksSystem[0].Implementer.Name
    
  #CONNECTED COMPONENT BY OneToOneInterface
  elif comp.findBehavioursByType(VC_ONETOONEINTERFACE):
    iface = comp.findBehavioursByType(VC_ONETOONEINTERFACE)[0]
    destination = [iface.ConnectedComponent]
    
  #CONNECTED COMPONENTS BY OneToManyInterface  
  elif comp.findBehavioursByType(VC_ONETOMANYINTERFACE):
    iface = comp.findBehavioursByType(VC_ONETOMANYINTERFACE)[0]
    destination = iface.ConnectedComponents
  
  #ADDITIONAL CONNECTIONS
  #You can also comment all before, and uncomment 2 lines below, and set your destination manualy
  #destinationComponentName = 'desiredDestination' #Write here the Component Name
  #destination = [app.findComponent(destinationComponentName)]
 
  #You can also add a component to connect to
  #destination = destination + [app.findComponent(destinationComponentName)]
  
  connectComModuleToReceiverScript(destination)

def connectComModuleToReceiverScript(destComp):
  global comModule
  #Whit lines below, this ComModule is connected to the receiver Script
  #So that when this ComModule sends a msg that needs ACK, the receiver will detect it, and send an ACK msg
  for compx in destComp:
    receiverComScript = compx.findBehaviour('CommunicationModuleScript')
    if receiverComScript not in comModule.Connections:
      comModule.Connections = comModule.Connections + [receiverComScript] 

def getTriggers():
  
  comInfoSignal.OnValueChange = infoSignalDetected


################################################################
## VARIABLE / OBJECT DECLARATION ###############################
################################################################

# GLOBAL VARIABLES


# BEHAVIOURS
comModule = comp.findBehaviour('CommunicationModule')
comModuleScript = comp.findBehaviour('CommunicationModuleScript')

comTriggerSignal = comp.findBehaviour('ComTriggerSignal')
comInfoSignal = comp.findBehaviour('ComInfoSignal')


################################################################
## FORMAT & ORDER OF MESSAGE FIELDS ############################
################################################################

# List of Keys
msgKeys = [
  'emitter', 
  'receiver',
  'msgType',
  'comType',
  'period', 
  'dataSize',
  'latency', 
  'reliability',
  'comTech', 
  'msgValue',
  'ackRequired']

################################################################
## MESSAGE TYPES ###############################################
################################################################

#Each Message Type must have it's own Dictionary

''' 
TEMPLATE FOR NEW DICTIONARIES
dicTemplate = {
  'emitter'     : comp.Name, 
  'receiver'    : controller.Name,
  'msgType'     : 'PalletRequest',
  'comType'     : 'a',   # 'p' = periodic  /  'a' = aperiodic
  'period'      : -1,   #ms 
  'dataSize'    : 64,    #bytes
  'latency'     : 100,   #ms
  'reliability' : 99.9,  #%
  'comTech'     : 'wl',  # 'wl' = WireLess  /  'wd' = Wired
  'msgValue'    : -1,
  'ackRequired' : True } #variable ack
'''

defaultMsg = {
  'emitter'     : comp.Name, 
  'receiver'    : 'DefaultReceiver',
  'msgType'     : 'Default',
  'comType'     : 'a',   # 'p' = periodic  /  'a' = aperiodic
  'period'      : -1,   #ms 
  'dataSize'    : 64,    #bytes
  'latency'     : 100,   #ms
  'reliability' : 99.9,  #%
  'comTech'     : 'wl',  # 'wl' = WireLess  /  'wd' = Wired
  'msgValue'    : -1,
  'ackRequired' : True } #variable ack

ackMsg = {
  'emitter'     : comp.Name, 
  'receiver'    : 'ACKReceiver',
  'msgType'     : 'ACK',
  'comType'     : 'a',   # 'p' = periodic  /  'a' = aperiodic
  'period'      : -1,   #ms 
  'dataSize'    : 64,    #bytes
  'latency'     : 100,   #ms
  'reliability' : 99.9,  #%
  'comTech'     : 'wl',  # 'wl' = WireLess  /  'wd' = Wired
  'msgValue'    : -1,
  'ackRequired' : False } #variable ack

periodicMsg = {
  'emitter'     : comp.Name, 
  'receiver'    : 'PeriodicReceiver',
  'msgType'     : 'PeriodicMsg',
  'comType'     : 'p',   # 'p' = periodic  /  'a' = aperiodic
  'period'      : 1000,   #ms 
  'dataSize'    : 64,    #bytes
  'latency'     : 100,   #ms
  'reliability' : 99.9,  #%
  'comTech'     : 'wl',  # 'wl' = WireLess  /  'wd' = Wired
  'msgValue'    : -1,
  'ackRequired' : False } #variable ack


################################################################
## CONDITIONS DICTIONARY #######################################
################################################################

## Put as a key the value of the ComTriggerSignal needed to send a certain msgType, and put as the value the Dictionary above that describes this msgType

conditionsDic = {
  'Default': defaultMsg,
  'Periodic': periodicMsg }
