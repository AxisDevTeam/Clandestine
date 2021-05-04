using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    CharacterController controller;

    [Header("Base & Current Speed")]
    public float baseSpeed = 12f;
    public float currentSpeed = 12f;

    [Header("Gravity")]
    public float gravity = -9.81f;

    [Header("Ground & Jump")]
    public Transform groundCheck;
    public float groundDistance = 0.4f;
    //no need to mark ground objects with ground layer, should work with all layers except for IgnoreRaycast
    public LayerMask groundMask;
    public float jumpHeight = 3f;

    [Header("Sprint Settings")]
    public bool isSprinting = false;
    public float sprintingSpeed;

    [Header("Crouch Settings")]
    public bool isCrouching = false;
    public float crouchingHeight = 2f;
    public float originalHeight = 3.8f;
    public float crouchingSpeed = 3f;



    Vector3 velocity;
    public bool isGrounded;

    private void Start()
    {
        controller = GetComponent<CharacterController>();
    }
    // Update is called once per frame
    void Update()
    {



        //this part is the groundcheck to stop velocity from becoming comedy

        isGrounded = Physics.CheckSphere(groundCheck.position, groundDistance, groundMask);

        if (isGrounded && velocity.y < 0)
        {
            velocity.y = -2f;
        }

        //this is the part about WASD & jumping
        float x = Input.GetAxis("Horizontal");
        float z = Input.GetAxis("Vertical");

        Vector3 move = transform.right * x + transform.forward * z;
        move = Vector3.ClampMagnitude(move,1f);

        controller.Move(move * currentSpeed * Time.deltaTime);

        if(Input.GetButtonDown("Jump") && isGrounded)
        {
            velocity.y = Mathf.Sqrt(jumpHeight * -2f * gravity);
        }

        // this is the part about gravity
        velocity.y += gravity * Time.deltaTime;

        controller.Move(velocity * Time.deltaTime);

        //This is about sprinting

        if (Input.GetKey(KeyCode.LeftShift))
        {
            isSprinting = true;
        }
        else
        {
            isSprinting = false;
        }   
    
            
        if (isSprinting == true)
        {
            currentSpeed = sprintingSpeed;
        }
        if (isSprinting == false)
        {
            currentSpeed = baseSpeed;
        }
  
    
        //This is about crouching
    
        if (Input.GetKey(KeyCode.LeftControl))
        {
            isCrouching = true;
        }
        else
        {
            isCrouching = false;
        }
        if (isCrouching == true)
        {
            isSprinting = false;
            controller.height = crouchingHeight;
            currentSpeed = crouchingSpeed;
            
        }
        else
        {
            controller.height = originalHeight;
        }
    
    }   


}
