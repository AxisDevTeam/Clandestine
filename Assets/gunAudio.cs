using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class gunAudio : MonoBehaviour
{
    public AudioSource randomSound;

    public AudioClip[] audioSources;

    private FMOD.Studio.EventInstance instance;

    public Transform player;

    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void RandomSound()
    {
        //randomSound.clip = audioSources[Random.Range(0, audioSources.Length)];
        //randomSound.Play();
        /*
        instance = FMODUnity.RuntimeManager.CreateInstance("event:/Gunshot");
        FMODUnity.RuntimeManager.AttachInstanceToGameObject(instance, player, GetComponent<Rigidbody>());
        instance.start();
        instance.release(); */

        FMODUnity.RuntimeManager.PlayOneShotAttached("event:/Gunshot", player.gameObject);
    }
}
