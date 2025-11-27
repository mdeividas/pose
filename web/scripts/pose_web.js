import {
  FilesetResolver,
  PoseLandmarker
} from "https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@latest";

let vision;
let poseLandmarker;

async function initPoseWeb(wasmPath, modelRelativePath) {
    if (poseLandmarker) return true;

    vision = await FilesetResolver.forVisionTasks(wasmPath);

    poseLandmarker = await PoseLandmarker.createFromOptions(vision, {
        baseOptions: {
            modelAssetPath: modelRelativePath
        },
        // TODO change to video / stream (?)
        runningMode: 'IMAGE'
    });

    return true;
}

async function detectPoseWebForImage(elementId) {
    const image = document.getElementById(elementId);
    return poseLandmarker.detect(image);
}

async function detectPoseWebForVideo(elementId) {
    const video = document.getElementById(elementId);
    return poseLandmarker.detectForVideo(video, performance.now());
}

window.initPoseWeb = initPoseWeb;
window.setImageSrc = setImageSrc;
window.detectPoseWebForImage = detectPoseWebForImage;
window.detectPoseWebForVideo = detectPoseWebForVideo;
