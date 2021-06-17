using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class gunAudio : MonoBehaviour
{
    public AudioSource randomSound;

    public AudioClip[] audioSources;

    private FMOD.Studio.EventInstance instance;

    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        instance = FMODUnity.RuntimeManager.CreateInstance("event:/Gunshot");
        instance.set3DAttributes(FMODUnity.RuntimeUtils.To3DAttributes(gameObject));
    }

    public void RandomSound()
    {
        //randomSound.clip = audioSources[Random.Range(0, audioSources.Length)];
        //randomSound.Play();
        
        
        instance.start();
        instance.release();
    }
}
