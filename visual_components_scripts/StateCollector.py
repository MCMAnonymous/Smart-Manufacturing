from vcScript import *
from vcScript import *
from vcHelpers.Robot2 import * 
import csv
import os.path
import time
import vcMatrix 
from vcHelpers.Selection import *
import os


#--------------------------------------------------------------------------#
# This behaviour logs the states of the components during the simulation   #
#--------------------------------------------------------------------------#



#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Folder where data is saved
output_folder = "CSV"
current_path = os.getcwd()
# path to the folder where the ouput csv files are generated
path = os.path.join(current_path, output_folder)

# data is written in the csv file every STEP_ITER
STEP_ITER = 10 #100

app = getApplication()
components = app.Components
# state information is collected in the Statistics behaviour
statistics = getComponent().findBehaviour('Statistics')
sim = getSimulation()
comp = getComponent()

component_states = {}

first_time_onChange=0

columns_states=['TimeStamp','Component', 'State']
counterStates=0
list_states_onChanged = []


list_states = []
result =0


# COUNTERS
count_register = 0
count_iter = 1

check_file = 0


# method to export data onChanged
def exportStatesOCInfo():
    global counterStates, list_states_onChanged
    f = open(os.path.join(path, "data_states.csv"), "a")

    # delimiter in the CSV file
    state_writer = csv.writer(f, delimiter=",", lineterminator='\n')

    for fila in list_states_onChanged:
        state_writer.writerow(fila)

    list_states_onChanged[:] = []
    counterStates=0
    f.close()  

def OnStart():
  global check_file, count_iter, count_iter, components, list_states_onChanged

  
  check_file = 0
  count_iter = 1
  
  
  # Log state information at the beggining of the simulation
  for component in components:
    if component.findBehaviour('Statistics'):
      statistics = component.findBehaviour('Statistics')
      state=statistics.State
      timeStamp = sim.SimTime
      name = component.Name
      if name not in ['EDGE', 'M3 Gage CMM']:
        row_new = [timeStamp, name, state]
        list_states_onChanged.append(row_new)
  
  # check if output folder exists
  if not os.path.exists(path):
    os.makedirs(path)

  #print("Output dir:", path)
    
  f = open(os.path.join(path, "data_states.csv"), "w")
  state_writer = csv.writer(f, delimiter=",", lineterminator='\n')
  state_writer.writerow(columns_states)
  for fila in list_states_onChanged:
        state_writer.writerow(fila)
  list_states_onChanged[:] = []
  f.close()  
  
  
  
# At the end of the simulation, write all data in "list_comms" to the output file
def OnStop():
  exportStatesOCInfo()
 
def onChangesProve():
  global component_states
  global first_time_onChange
  
  # Create onChanged event for every component in the layout and log the name in the dictionary
  if first_time_onChange==0:
    for component in components:
      if component.findBehaviour('Statistics'):
        statistics = component.findBehaviour('Statistics')
        name = component.Name
        component_states[name] = statistics.State
    first_time_onChange += 1
    
                
def monitorAndUpdateStates():
    global component_states, counterStates, list_states_onChanged
    for component in components:
        if component.findBehaviour('Statistics'):
            statistics = component.findBehaviour('Statistics')
            name = component.Name
            timeStamp = sim.SimTime
            # Update when state changes
            if component_states[name] != statistics.State:
                component_states[name] = statistics.State
                # add a new register
                row_new = [timeStamp, name, statistics.State]
                #print(row_new)
                list_states_onChanged.append(row_new)
                counterStates += 1
                if counterStates > 50:
                    exportStatesOCInfo()
  






            
def OnRun():
  onChangesProve() # First iteration
  while True:
      delay(0.1)
      monitorAndUpdateStates()
 