from vcScript import *
from random import randint

app = getApplication()
comp = getComponent()
sim = getSimulation()
comp = getComponent()
failures=comp.getProperty('FailureSimulationEnabled')   #<------failHandler--------

if failures.Value==1:

  def OnSignal( signal ):
    pass


  def OnStart():
    global comp_broken,comp,comp_stop,comp_failure_type,comp_current_MTBF,comp_current_MTTR,N_failures
    
    #Properties are created: 
    # MeanTimeBetweenFailures
    # MeanTimeToRepair
    # Broken: flag which is True if device is broken
    
    
    comp.Available=True
    # Different types of failures or malfunctions can occur
    
    N_failures=3 #Number of types of failures or malfunctions
    
    #_____FAILURE TYPE 1_______
    # MeanTimeBetweenFailures 
    seed_failure_1=randint(0,63)
    # Variables to be seen by ResourceScript
    error1_MTBF=comp.createProperty(VC_REAL, 'Error1_MTBF') 
    
    lambda_failure_1=0.00027778  # lambda=1 failure/year*year/3600s=1/3600
    #print(comp.Name,'--->Seed_failure_1_distribution:',seed_failure_1)
    
    #MC dist_MTBF1="exponential("+str(lambda_failure_1)+")"
    comp_MTBF_1 = comp.createProperty(VC_DISTRIBUTION, "Error1_StatisticDistribution")
    #comp_MTBF_1.Distribution = "exponential(0.00027778)" 
    #MC comp_MTBF_1.Distribution = dist_MTBF1
    comp_MTBF_1.Distribution= "normal(7000.0, 500.0)"
    comp_MTBF_1.RandomStream=seed_failure_1
    
   #MeanTimeToRepair 
    error1_MTTR=comp.createProperty(VC_REAL, 'Error1_MTTR')
    comp_MTTR_1 = comp.createProperty(VC_DISTRIBUTION, "Error1_TTRModel")
    comp_MTTR_1.Distribution= "normal(500.0, 500.0)"
    comp_MTTR_1.RandomStream=seed_failure_1
    
    #____________FAILURE 2__________________________________________
    #MeanTimeBetweenFailures
    seed_failure_2=randint(0,63)
    error2_MTBF=comp.createProperty(VC_REAL, 'Error2_MTBF')
    lambda_failure_2=0.000333333 # lambda=1.2 failure/year*year/3600s=1/3600
    print(comp.Name,'--->Seed_failure_2_distribution:',seed_failure_2)
    
    #MC dist_MTBF2="exponential("+str(lambda_failure_2)+")"
    comp_MTBF_2 = comp.createProperty(VC_DISTRIBUTION, "Error2_StatisticDistribution")
    #comp_MTBF_2.Distribution = "exponential(0.000333333)"
    #MC comp_MTBF_2.Distribution = dist_MTBF2
    comp_MTBF_2.Distribution= "normal(7000.0, 500.0)"
    comp_MTBF_2.RandomStream=seed_failure_2
    
   #MeanTimeToRepair
    error2_MTTR=comp.createProperty(VC_REAL, 'Error2_MTTR')
    comp_MTTR_2 = comp.createProperty(VC_DISTRIBUTION, "Error2_TTRModel")
    comp_MTTR_2.Distribution= "normal(500.0, 500.0)"
    comp_MTBF_2.RandomStream=seed_failure_2
    
    #____________FAILURE 3__________________________________________
    #MeanTimeBetweenFailures
    seed_failure_3=randint(0,63)
    error3_MTBF=comp.createProperty(VC_REAL, 'Error3_MTBF')
    lambda_failure_3=0.000555556 # lambda=2 failure/year*year/3600s=2/3600
    print(comp.Name,'--->Seed_failure_3_distribution:',seed_failure_3)
    
    #MC dist_MTBF3="exponential("+str(lambda_failure_3)+")"
    comp_MTBF_3 = comp.createProperty(VC_DISTRIBUTION, "Error3_StatisticDistribution")
    #comp_MTBF_3.Distribution = "exponential(0.000555556)"
    #MC comp_MTBF_3.Distribution = dist_MTBF3
    comp_MTBF_3.Distribution= "normal(7000.0, 500.0)"
    comp_MTBF_3.RandomStream=seed_failure_3
    
   #MeanTimeToRepair
    error3_MTTR=comp.createProperty(VC_REAL, 'Error3_MTTR')
    comp_MTTR_3 = comp.createProperty(VC_DISTRIBUTION, "Error3_TTRModel")
    comp_MTTR_3.Distribution= "normal(500.0, 500.0)"
    comp_MTBF_3.RandomStream=seed_failure_3
    
    #_____________________________________________________________________
    
    
    
    # Variables to be seen by ResourceScript
    comp_current_MTBF=comp.createProperty(VC_REAL, 'next_error_time')
    comp_current_MTTR=comp.createProperty(VC_REAL, 'next_repair_time')
    
    #failures vector  
    comp_failures_v=[] 
    
    #failure flag
    comp_broken = comp.createProperty(VC_BOOLEAN, 'Broken')
    
    #1-> TRUE  Y  0-> FALSE
    comp_broken.WritableWhenSimulating=True
    comp_broken.Value= False
    #print(comp_broken.Value)
    
    #shows type of failure 
    comp_failure_type = comp.createProperty(VC_INTEGER, 'FailureType')
    comp_failure_type.Value =0   # 0-> repaired 
    
    
    #---PROBAMOS CONSTANTES-------
    comp_stop=comp.getProperty("Available") # NO se usa
    
   
    


  def OnRun():
    
    global comp_broken, sim,comp_failure_type,comp_current_MTBF,comp_current_MTTR,N_failures
    
    comp = getComponent()
    comp_stats= comp.findBehaviour("Statistics")
    mtbf_v=[]     #contains the absolute time between failures
    mttr_v=[]     #contains the absolute repair time duration
    failures_next_times=[] #contains the time stamps of the next failures
    
    #comp_broken.Value=0
    
    
    #-------------several MTBFS, STILL ON DESIGN-----------------------------------
    '''
    #firstly , the MTBFs and MTTRs vectors(python list ) are full filled with the
    #generated  MTBFs and MTTRs for all error type
    '''
    for i in range(N_failures):
        if i==0:
            mtbf=comp.MTBF_1
            mttr=comp.MTTR_1
            
        elif i==1:
            mtbf=comp.MTBF_2
            mttr=comp.MTTR_2
        elif i==2:
            mtbf=comp.MTBF_3
            mttr=comp.MTTR_3    
        
        
        mtbf_v.append(mtbf)     
        mttr_v.append(mttr)      
       
    #failures_next_times = [x + sim.SimTime for x in mtbf_v]  LO QUITO
    print(comp.Name,'--->mtbf_v',mtbf_v)
    #------------------------------------------------------------------------------
    
    while True:
      next_time_stamp_error = min(mtbf_v);        
      next_error_type_index = mtbf_v.index(next_time_stamp_error) 
      
      #waiting fot failure 
      delay(mtbf_v[next_error_type_index])
      delay(10)                                          
      
      #variables to stop the component main Script
      comp_current_MTBF.Value = mtbf_v[next_error_type_index]
      comp_current_MTTR.Value = mttr_v[next_error_type_index]
      comp_failure_type.Value = next_error_type_index+1     # 0 means repaired
      
      #failure 
      comp_broken.Value=True
      print(comp.Name,'--> broken at',sim.SimTime)
       
      
      #the mttr has to be added to the time between failures to know which failure is going to happen earlier
      
      #    update time to next failure
      for i in range(N_failures):
        if i!=next_error_type_index:
          mtbf_v[i]-=(mtbf_v[next_error_type_index])
            
           
          
      #the error time  from the one that already happen is updated
      if next_error_type_index==0:
        mtbf=comp.MTBF_1;
        mttr=comp.MTTR_1;
      elif next_error_type_index==1:
        mtbf=comp.MTBF_2;
        mttr=comp.MTTR_2;
      elif next_error_type_index==2:
        mtbf=comp.MTBF_3;
        mttr=comp.MTTR_3;
        
      else:
        print('error occurs')
              
      mtbf_v[next_error_type_index]=mtbf;

      mttr_v[next_error_type_index]=mttr;
      print(mtbf_v,sim.SimTime)
     
      delay (0.05)
      

  #Event hander which is executed when simulation is stopped 
  def OnStop():
    #exportFailureInfo()
    pass

  def failHandler(comp,comp_stats,comp_failure_type,comp_broken,comp_current_MTTR,sim,failure_data_list):
    #This Function has to be called in the MAIN LOOP(OnRun) of the Device main Script(a vcScript behaviour)
    #
    #
    #comp_stats         -> Component property "Statatistics"
    #comp               -> Component 
    #comp_broken        -> component property which indicates if the Component is broken
    #sim                -> simlulation object
    #failure_data_list  -> each element contains [timeStamp, Component, FailureType]
    
    comp_stats.State='Break'
    failType=comp_failure_type
    
    failure_data_list.append([sim.SimTime,comp.Name,failType,comp_broken.Value])
    
    
    print(comp.Name,'broken at',sim.SimTime,'I´ll be repaired in ',comp.MTTR,"seconds")
    comp_stats.State='Repairing'
    delay(comp_current_MTTR)
    
    
    delay(0.5)
    comp_stats.State='Fixed'
    comp_broken.Value=False
    failure_data_list.append([sim.SimTime,comp.Name,failType,comp_broken.Value])  # 0-> Fixed 
    
    print(comp.Name,'Im back','at',sim.SimTime)
    return failure_data_list
    