using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class footstepsSound : MonoBehaviour
{

    public PlayerMovement pm;

    [FMODUnity.EventRef]
    public string sound = "";

    public GameObject soundOrigin;
    // Start is called before the first frame update

    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void footstep() {
        if (pm.isGrounded)
        {
            RaycastHit hit;
            if(Physics.Raycast(transform.position,-transform.up, out hit,Mathf.Infinity,pm.groundMask)){
                floorType ft = hit.transform.gameObject.GetComponent<floorType>();
                if (ft != null) {
                    FMOD.Studio.EventInstance step = FMODUnity.RuntimeManager.CreateInstance(sound);
                    switch (ft.floorT)
                    {
                        case floorType.TypeOfFloor.Stone:
                            print("Type found: Stone");
                            step.setParameterByName("Type", 0);
                            step.set3DAttributes(FMODUnity.RuntimeUtils.To3DAttributes(soundOrigin));
                            step.start();
                            step.release();
                            break;
                        case floorType.TypeOfFloor.Wood:
                            print("Type found: Wood");
                            step.setParameterByName("Type", 1);
                            step.set3DAttributes(FMODUnity.RuntimeUtils.To3DAttributes(soundOrigin));
                            step.start();
                            step.release();
                            break;
                        case floorType.TypeOfFloor.Water:
                            print("Type found: Water");
                            step.setParameterByName("Type", 2);
                            step.set3DAttributes(FMODUnity.RuntimeUtils.To3DAttributes(soundOrigin));
                            step.start();
                            step.release();
                            break;
                        case floorType.TypeOfFloor.Carpet:
                            print("Type found: Carpet");
                            step.setParameterByName("Type", 3);
                            step.set3DAttributes(FMODUnity.RuntimeUtils.To3DAttributes(soundOrigin));
                            step.start();
                            step.release();
                            break;
                    }
                    
                }
                else
                {
                    print("type not found: default (stone)");
                    FMOD.Studio.EventInstance step = FMODUnity.RuntimeManager.CreateInstance(sound);
                    step.setParameterByName("Type", 0);
                    step.set3DAttributes(FMODUnity.RuntimeUtils.To3DAttributes(soundOrigin));
                    step.start();
                    step.release();
                }
            }
        }
    }

}
