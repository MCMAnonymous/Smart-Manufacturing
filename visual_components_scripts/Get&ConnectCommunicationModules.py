from vcScript import *

#------------------------------------------------------------------------#
# This Script establishes connections between the 'CommunicationModule'  #
# signal of every component in the layout and the CommCollector          #
# behaviour within the MWssageLogger                                     #
#------------------------------------------------------------------------#

comp = getComponent()
app = getApplication()
sim = getSimulation()
button = comp.getProperty('ComSetup :: ConnectAllComModules')

def OnStart():
  global comp, app, sim, button
  
  #Uncomment which one it is wanted to be collected
  #this = comp.findBehaviour('PrintComModules')
  dataCollectorScript = comp.findBehaviour('CommCollector')
  stateCollectorScript = comp.findBehaviour('StateCollector')

  

  comModulesList = []
  compList = []
  count = 0
  for compo in app.Components:
    if compo.findBehaviour('CommunicationModule') != None: 
      comModulesList.append(compo.findBehaviour('CommunicationModule'))
      compList.append(compo.Name)
      count += 1
  print 'Components with CommunicationModule',count#, ':', compList

  for x in comModulesList:
    if dataCollectorScript not in x.Connections:
      x.Connections = x.Connections + [dataCollectorScript]



  for x in comModulesList:
    if stateCollectorScript not in x.Connections:
      x.Connections = x.Connections + [stateCollectorScript]
      
pass

def connectAllComModules(prop):
  comModulesList = []
  compList = []
  count = 0
  for compo in app.Components:
    if compo.findBehaviour('CommunicationModule') != None: 
      comModulesList.append(compo.findBehaviour('CommunicationModule'))
      compList.append(compo.Name)
      count += 1
  print 'Components with CommunicationModule',count, ':', compList
  
  for x in comModulesList:
    if dataCollectorScript not in x.Connections:
      x.Connections = x.Connections + [dataCollectorScript]
  
  for x in comModulesList:
    if stateCollectorScript not in x.Connections:
      x.Connections = x.Connections + [stateCollectorScript]

button.OnChanged = connectAllComModules

