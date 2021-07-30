using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class objectInteract : MonoBehaviour
{

    public GameObject last;
    public GameObject target;
    public float pushForce = 30f;
    public float moveSpeed;
    public Camera c;
    public float rayDist;
    public LayerMask layerMask;

    public float chargeTime = 0.25f;
    public float currentTime = 0f;
    public bool chargeCounting;



    // Start is called before the first frame update
    void Start()
    {
        c = Camera.main;
    }

    // Update is called once per frame
    void Update()
    {
        RaycastHit hit;
        if (Input.GetMouseButton(0))
        {
            if (Physics.Raycast(transform.position, transform.forward, out hit, rayDist, layerMask))
            {
                if (chargeCounting == false)
                {
                    last = hit.transform.gameObject;
                }
                
            }
        }

        if (Input.GetMouseButton(0) == false)
        {
            last = null;
        }
        else
        {
            if (last)
            {
                
                last.transform.gameObject.GetComponent<Rigidbody>().velocity = ((target.transform.position - last.transform.position) * moveSpeed);
                if (Input.GetMouseButtonDown(1))
                {
                    last.GetComponent<Rigidbody>().AddForce(transform.forward.normalized * pushForce);
                    chargeCounting = true;
                    last = null;
                }
            }
        }

        if (chargeCounting)
        {
            currentTime += Time.deltaTime;
            if (currentTime >= chargeTime)
            {
                chargeCounting = false;
            }
        }
        else
        {
            currentTime = 0;
        }
    }
}
