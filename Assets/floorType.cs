using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class floorType : MonoBehaviour
{
    // Start is called before the first frame update
    [Header("1=Stone")]
    [Header("2=Wood")]
    [Header("3=Water")]
    [Header("4=Carpet")]
    public float type = 1;

    public enum TypeOfFloor { Stone, Wood, Water, Carpet };
    public TypeOfFloor floorT = (int)TypeOfFloor.Stone;
    void Start()
    {
    }
    

    // Update is called once per frame
    void Update()
    {
        
    }
}
