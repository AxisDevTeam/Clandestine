using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    public CharacterController controller;

    public float speed = 12f;
   

    public float gravity = -9.81f;

    public Transform groundCheck;
    public float groundDistance = 0.4f;
    public LayerMask groundMask;
    public float jumpHeight = 3f;

    public bool isSprinting = false;
    public float sprintingSpeed;

    public bool isCrouching = false;
    public float crouchingHeight = 2f;
    public float originalHeight = 3.8f;



    Vector3 velocity;
    public bool isGrounded;

    // Update is called once per frame
    void Update()
    {
       
               

        //this part is the groundcheck to stop velocity from becoming comedy
        isGrounded = Physics.CheckSphere(groundCheck.position, groundDistance, groundMask);

        if(isGrounded && velocity.y < 0)
        {
            velocity.y = -2f;
        }

        //this is the part about WASD & jumping
        float x = Input.GetAxis("Horizontal");
        float z = Input.GetAxis("Vertical");

        Vector3 move = transform.right * x + transform.forward * z;

        controller.Move(move * speed * Time.deltaTime);

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
            speed = sprintingSpeed;
        }
        if (isSprinting == false)
        {
            speed = 12f;
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
            speed = 3f;
            
        }
        else
        {
            controller.height = originalHeight;
        }
    
    }   


}
