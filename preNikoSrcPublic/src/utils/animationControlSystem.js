import * as THREE from "three";

/**
 * Controls an animation sequence that can be played in both directions
 * based on scroll progress.
 */
export class ScrollAnimationController {
  constructor() {
    this.animations = [];
    this.currentProgress = 0;
    this.previousProgress = 0;
  }

  /**
   * Add an animation to the sequence with its trigger point
   */
  addAnimation(animation) {
    this.animations.push({
      ...animation,
      currentWeight: 0,
      isPlaying: false,
      mixer: animation.action.getMixer(),
    });

    // Sort animations by trigger point
    this.animations.sort((a, b) => a.triggerPoint - b.triggerPoint);
    return this;
  }

  /**
   * Update animations based on scroll progress (0-1)
   */
  update(progress) {
    const isScrollingDown = progress > this.previousProgress;
    const delta = progress - this.previousProgress;

    if (Math.abs(delta) < 0.001) return;

    this.animations.forEach((anim) => {
      const shouldActivate =
        (progress >= anim.triggerPoint &&
          progress < anim.triggerPoint + anim.duration) ||
        (anim.isPlaying && Math.abs(progress - anim.triggerPoint) < 0.1);

      if (shouldActivate && !anim.isPlaying) {
        anim.isPlaying = true;
        anim.action.reset();
        anim.action.clampWhenFinished = true;
        anim.action.setLoop(THREE.LoopOnce);
        anim.action.play();
      }

      if (anim.isPlaying) {
        const localProgress = Math.max(
          0,
          Math.min(1, (progress - anim.triggerPoint) / anim.duration)
        );
        const clipDuration = anim.action.getClip().duration;

        if (isScrollingDown) {
          anim.mixer.setTime(localProgress * clipDuration);
        } else {
          anim.mixer.setTime((1 - localProgress) * clipDuration);
        }

        if (
          progress < anim.triggerPoint ||
          progress > anim.triggerPoint + anim.duration
        ) {
          anim.isPlaying = false;
        }
      }
    });

    this.previousProgress = progress;
  }

  /**
   * Clean up all animations
   */
  dispose() {
    this.animations.forEach((anim) => {
      anim.action.stop();
    });
    this.animations = [];
  }
}
