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
    public float amountDecrease = 20f;
    public float amountIncrease = 10f;
    public bool recharging;
    public float Stamina = 100f;

    [Header("Crouch Settings")]
    public bool isCrouching = false;
    public float crouchingHeight = 2f;
    public float originalHeight = 3.8f;
    public float crouchingSpeed = 3f;


    


    Vector3 velocity;
    public bool isGrounded;

    //after you jump, whatever velocity you had when you pressed space is carried through while you jump.
    Vector3 jumpContinue;

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

        if (isGrounded == true)
        {
            controller.Move(move * currentSpeed * Time.deltaTime);
        }
        else
        {
            controller.Move((jumpContinue+move)/2 * currentSpeed * Time.deltaTime);
        }
        

        if(Input.GetButtonDown("Jump") && isGrounded)
        {
            velocity.y = Mathf.Sqrt(jumpHeight * -2f * gravity);
            jumpContinue = move;
        }

        // this is the part about gravity
        velocity.y += gravity * Time.deltaTime;

        controller.Move(velocity * Time.deltaTime);

        //This is about sprinting
        //Remember to fix the game thinking you're sprinting when you stand still & holding shift

        if (recharging == true) isSprinting = false;
       
        
        if (Input.GetKey(KeyCode.LeftShift))
        {
           if(recharging == false) isSprinting = true;
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
            transform.localScale =new Vector3 (transform.localScale.x, crouchingHeight, transform.localScale.z);
            currentSpeed = crouchingSpeed;
            
        }
        else
        {
            transform.localScale =new Vector3(transform.localScale.x, originalHeight, transform.localScale.z);
        }

   
        //this is about sprinting stamina
        if (isSprinting == true)
        {
            Stamina -= amountDecrease * Time.deltaTime;
        }
        else
        {
            Stamina += amountIncrease * Time.deltaTime;
        }
        if (Stamina <= 0f)
        {
            recharging = true;
            isSprinting = false;
        }
        if (Stamina >= 100f)
        {
            recharging = false;
        }

        Stamina = Mathf.Clamp(Stamina, 0f, 100f);
    }   


}
