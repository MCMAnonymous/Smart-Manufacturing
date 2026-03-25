from vcScript import *
from vcHelpers.Robot2 import * 
import csv
import os.path
import time
import vcMatrix 
from vcHelpers.Selection import *
import os

#---------------------------------------------------------#
# This script logs the positions of each component in the #
# layout into a CSV file:                                 #
#                                                         #
#---------------------------------------------------------#

app = getApplication()
sim = app.getSimulation() 
dict_last_log = {}
list_data_all = []
# Folder where data is saved
folder_name = "CSV"
# current path
current_path = os.getcwd()
# CSV folder path
path = os.path.join(current_path, folder_name)

cont_iter = 0
cont = 0
# data is written in the csv file after STEP_ITER
STEP_ITER = 10
# Minimum distance a component must move to register a new position
STEP_DIST = 1

def exportData():
 
  # open file
  f = open(os.path.join(path, "data_position.csv"), "a")
  
  # delimitir in the csv file
  state_writer = csv.writer(f, delimiter=",", lineterminator='\n')
  first_iter = 0
  for row_i in list_data_all:
    state_writer.writerow(row_i)

  f.close()
  del list_data_all[:]


def exportDataUnique():
  global cont_iter, cont, list_data_all, dict_last_log, app
  
  # Get component list
  listComponents = app.Components 
 
  
  # Execute continuosly during the simulation
  while True:
    for componentN in listComponents:
      #if not (componentN.BOMdescription == "Human"):  
      pos_x = "{:.3f}".format(componentN.WorldPositionMatrix.P.X)
      pos_y = "{:.3f}".format(componentN.WorldPositionMatrix.P.Y)
      pos_z = "{:.3f}".format(componentN.WorldPositionMatrix.P.Z)
      ori_x = "{:.3f}".format(componentN.WorldPositionMatrix.WPR.X)
      ori_y = "{:.3f}".format(componentN.WorldPositionMatrix.WPR.Y)  
      ori_z = "{:.3f}".format(componentN.WorldPositionMatrix.WPR.Z)
      positions = str(pos_x) + " " + str(pos_y) + " " + str(pos_z)
      orientations = str(ori_x) + " " + str(ori_y) + " " + str(ori_z)
      # We can get an error the first time because the dictionary is empty
      try:
        if not (dict_last_log[componentN.Name][2] == positions and dict_last_log[componentN.Name][3] == orientations):
          # check how much position has changed
          last_position = dict_last_log[componentN.Name][2].split(';')
          pos_x_aux = float(last_position[0])
          pos_y_aux = float(last_position[1])
          pos_z_aux = float(last_position[2])
          if (abs(pos_x - pos_x_aux) >= STEP_DIST or abs(pos_y - pos_y_aux) >= STEP_DIST or abs(pos_z - pos_z_aux) >= STEP_DIST ):
            #dict_last_log[componentN.Name] = [componentN.Name,str(sim.SimTime),positions,orientations]
            cont_iter += 1
            list_data_all.append([cont_iter,componentN.Name,str(sim.SimTime),str(pos_x),str(pos_y),str(pos_z),str(ori_x),str(ori_y),str(ori_z)])
            cont += 1
      except:
        dict_last_log[componentN.Name] = [componentN.Name,str(sim.SimTime),positions,orientations]
        cont_iter += 1
        list_data_all.append([cont_iter,componentN.Name,str(sim.SimTime),str(pos_x),str(pos_y),str(pos_z),str(ori_x),str(ori_y),str(ori_z)])
        cont += 1
      # write data in file after STEP_ITER registers
      if cont == STEP_ITER:
        cont=0
        exportData()
    delay(0.5)

def OnStart():

  column_names = ['Iteracion','Name' ,'Time', 'Position_X', 'Position_Y', 'Position_Z', 'Orientation_X', 'Orientation_Y', 'Orientation_Z']
  
  # create csv file
  if not os.path.exists(path):
    os.makedirs(path)

  #print("Path:", path)  

  # open file
  f = open(os.path.join(path, "data_position.csv"), "w")
  
  # delimiter in csv file
  state_writer = csv.writer(f, delimiter=",", lineterminator='\n')
  
  # write the name of the columns in the csv file
  
  state_writer.writerow(column_names)
  f.close()
  

def OnRun():
 exportDataUnique()

def OnStop():
  exportData()
