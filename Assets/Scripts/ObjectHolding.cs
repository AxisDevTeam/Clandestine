using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//using UnityEngine.InputSystem;
public class ObjectHolding : MonoBehaviour
{
    public GameObject target;
    public GameObject item;
    public GameObject lastItem;
    public Vector3 dir;
    public float speed;
    public float damping = 0.7f;
    public Vector3 lastDir = Vector3.zero;
    public float throwForce = 4500f;
    public RaycastHit hit;
    public string hitP;
    public float rayDist = 2f;
    public bool holding = false;
    public Vector3 targetOriginal;
    public float scrollSpeed = 1f;
    public Vector3 tPos;
    public float counter;
    public float waittimer;
    public float timer;
    public Quaternion rot;
    public Animator crosshair;
    public bool isRotating = false;
    public float rotateSpeed;
    public GameObject player;

    //private PlayerControls control;
    // Start is called before the first frame update
    private void Awake()
    {
        //control = new PlayerControls();
    }
    private void OnEnable()
    {
        //control.Enable();
    }
    private void OnDisable()
    {
        //control.Disable();
    }
    void Start()
    {
        targetOriginal = target.transform.localPosition;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if (hit.collider)
        {
            hitP = hit.collider.ToString();
        }
        if (holding == false)
        {
            lastItem = item;
            if (Physics.Raycast(transform.position, transform.forward, out hit, rayDist))
            {
                if (hit.collider.gameObject.tag == "item")
                {
                    //if (control.Gameplay.Hold.ReadValue<float>() == 1)
                    //{
                    //   holding = true;
                    //    item = hit.collider.gameObject;
                    //   
                    //}
                    crosshair.SetBool("Open", true);
                }
                else
                {
                    crosshair.SetBool("Open", false);
                }
            }
            else
            {
                crosshair.SetBool("Open", false);
            }
            target.transform.localPosition = new Vector3(0,0,0);
        }
        if (item)
        {
            if (target.transform.localPosition == new Vector3(0, 0, 0))
            {
                target.transform.localPosition = new Vector3(0, 0, Vector3.Distance(Camera.main.transform.position, item.transform.position));
            }
            item.GetComponent<Rigidbody>().angularDrag = 10000;
            if (item.GetComponent<Rigidbody>().mass <= 1)
            {
                speed = 20;
            }
            else if(item.GetComponent<Rigidbody>().mass > 1 && item.GetComponent<Rigidbody>().mass <= 5)
            {
                speed = 18;
            }
            else if (item.GetComponent<Rigidbody>().mass > 5 && item.GetComponent<Rigidbody>().mass <= 20)
            {
                speed = 12;
            }
            else if (item.GetComponent<Rigidbody>().mass > 20 && item.GetComponent<Rigidbody>().mass <= 35)
            {
                speed = 8;
            }
            else if (item.GetComponent<Rigidbody>().mass > 35)
            {
                speed = 6;
            }
        }
        else if(lastItem!=null)
        {
            lastItem.GetComponent<Rigidbody>().angularDrag = 0;
        }

        //if (control.Gameplay.Hold.ReadValue<float>() != 1)
        //{
        //    if (item)
        //    {
        //        item.GetComponent<Rigidbody>().angularDrag = 0;
        //    }
        //    holding = false;
        //    
        //}
        if(holding==true&& Vector3.Distance(item.transform.position, target.transform.position) > 4)
        {
            holding = false;
            
        }
        if (holding == true)
        {
            item.layer = 12;
        }
        else
        {
            if (item != null)
            {
                item.layer = 0;
            }
        }

        if (timer < 10)
        {
            timer = timer + Time.deltaTime;
        }
        if (timer > waittimer)
        {
            counter = 0;
        }
        else
        {
            if (lastItem == item)
            {
                holding = false;
            }
        }

        if (holding)
        {
            if (Input.GetMouseButton(1))
            {
                if (counter == 0)
                {


                    item.GetComponent<Rigidbody>().AddForce(target.transform.forward * throwForce);
                    counter = counter + 1;
                    holding = false;
                    timer = 0;
                }

            }
            else
            {
                dir = target.GetComponent<Transform>().position - item.GetComponent<Transform>().position;
                lastDir = Vector3.Lerp(dir, lastDir, damping);
                item.GetComponent<Rigidbody>().velocity = lastDir * speed;
                //item.GetComponent<Transform>().rotation = target.GetComponent<Transform>().rotation;
            }
            tPos = target.transform.localPosition + new Vector3(0, 0, Input.GetAxis("Mouse ScrollWheel") * scrollSpeed);
            tPos.z = Mathf.Clamp(tPos.z, 2.5f, 10f);
            target.transform.localPosition = tPos;

            if (Input.GetKey("r"))
            {
                isRotating = true;
            }
            else
            {
                isRotating = false;
            }
        }
        else
        {
            isRotating = false;
        }

        //if (isRotating)
        //{
        //    //pl.doMouseMovement = false;
        //    item.transform.RotateAround(item.transform.position, transform.right, control.Gameplay.LookV.ReadValue<float>() * Time.deltaTime * rotateSpeed);
        //    item.transform.RotateAround(item.transform.position, -transform.up, control.Gameplay.LookH.ReadValue<float>() * Time.deltaTime * rotateSpeed);
        //}
        if (isRotating == false)
        {
            //pl.doMouseMovement = true;
            

        }
    }


}
