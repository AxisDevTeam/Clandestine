using UnityEngine;

public class Gun : MonoBehaviour
{
    public float damage = 10f;
    public float range = 100f;
    public bool reloading = false;

    public Camera fpsCam;

    public Animator anim;

    // Update is called once per frame
    void Update()
    {
        //print(anim.GetCurrentAnimatorStateInfo(0).IsName("reload") && anim.GetCurrentAnimatorStateInfo(0).normalizedTime<1f);
        if (Input.GetKeyDown("r"))
        {
            anim.SetTrigger("Reload");
        }

        anim.SetBool("Reloading", reloading);

        if(anim.GetCurrentAnimatorStateInfo(0).IsName("reload") && anim.GetCurrentAnimatorStateInfo(0).normalizedTime < 1f)
        {
            reloading = true;
        }
        else
        {
            reloading = false;
        }
        if (Input.GetMouseButtonDown(0))
        {
            Shoot();
            if (reloading == false)
            {
                anim.SetTrigger("Shoot");
            }
            
        }
    }

    void Shoot()
    {
        RaycastHit hit;
        if (Physics.Raycast(fpsCam.transform.position, fpsCam.transform.forward, out hit, range))
        {
            Debug.Log(hit.transform.name);
            //tells you what got hit

            Shootthis target = hit.transform.GetComponent<Shootthis>();
            if (target != null)
            {
                target.TakeDamage(damage);
            }
        }
    }
}
