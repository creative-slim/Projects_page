import * as THREE from "three";

/**
 * Smoothly transitions between animations, automatically detecting currently playing animations
 * @param {Object} actions - All available animation actions
 * @param {Object} toAction - The animation action to transition to
 * @param {Object} options - Transition options
 * @param {number} options.crossFadeTime - Duration of crossfade between animations
 * @param {number} options.fadeInDuration - Duration of fade-in for the initial animation
 * @param {Object} [fromAction] - Optional specific starting animation (overrides auto-detection)
 */
export function playAnimationTransition(
  actions,
  toAction,
  options = {},
  fromAction = null
) {
  const { crossFadeTime = 0.5, fadeInDuration = 0.2 } = options;

  // Safety checks
  if (!toAction) {
    console.error("Target animation is undefined");
    return;
  }

  // Find currently playing animation if fromAction not specified
  if (!fromAction) {
    const playingActions = getActiveAnimations(actions);

    // Use the first playing action if any exist
    fromAction = playingActions.length > 0 ? playingActions[0].action : null;
  }

  // If no animation is currently playing, just play the toAction directly
  if (!fromAction) {
    console.log(
      `No source animation detected, playing ${
        toAction.getClip().name
      } directly`
    );
    // Stop all other animations to be safe
    stopAllAnimations(actions, [toAction]);

    toAction.reset();
    toAction.fadeIn(fadeInDuration);
    toAction.play();
    return;
  }

  console.log(
    `Transitioning from ${fromAction.getClip().name} to ${
      toAction.getClip().name
    }`
  );

  // First, stop all other animations that might be running (except source and target)
  stopAllAnimations(actions, [fromAction, toAction]);

  // Perform the transition
  fromAction.reset();
  fromAction.setLoop(THREE.LoopOnce, 1);
  fromAction.clampWhenFinished = true;
  fromAction.fadeIn(fadeInDuration);
  fromAction.play();

  fromAction.getMixer().addEventListener("finished", onFinished);

  function onFinished() {
    if (toAction) {
      toAction.reset();
      fromAction.crossFadeTo(toAction, crossFadeTime, true);
      toAction.fadeIn(crossFadeTime);
      toAction.play();
    }
    // Remove the event listener to prevent memory leaks
    fromAction.getMixer().removeEventListener("finished", onFinished);
  }
}

/**
 * Stops all animations except the ones in the exclude list
 * @param {Object} actions - All available animation actions
 * @param {Array} [excludeList=[]] - List of actions to exclude from stopping
 * @param {boolean} [fullReset=false] - Whether to fully reset the animations
 */
export function stopAllAnimations(actions, excludeList = [], fullReset = true) {
  Object.values(actions).forEach((action) => {
    if (action && !excludeList.includes(action)) {
      if (fullReset) {
        // Fully reset the animation
        action.stop();
        action.reset();
        action.weight = 0;
      } else {
        // Just fade it out
        action.fadeOut(0.2);
      }
    }
  });
}

/**
 * Properly resets the animation state by stopping all animations
 * and removing any leftover weights
 * @param {Object} actions - All available animation actions
 */
export function resetAnimationState(actions) {
  if (!actions) return;

  Object.values(actions).forEach((action) => {
    if (action) {
      // Completely reset the animation
      action.stop();
      action.reset();
      action.weight = 0;
      action.enabled = false;
    }
  });
}

/**
 * Gets information about the currently playing animations using enhanced detection
 * @param {Object} actions - All available animation actions
 * @returns {Object[]} Array of currently playing animations with their names and details
 */
export function getCurrentAnimations(actions) {
  return getActiveAnimations(actions, true);
}

/**
 * Gets all active animations with more flexible detection criteria
 * @param {Object} actions - All available animation actions
 * @param {boolean} [strictMode=false] - If true, use stricter criteria for detection
 * @returns {Object[]} Array of active animations with their names and details
 */
export function getActiveAnimations(actions, strictMode = false) {
  if (!actions) {
    return [];
  }

  // Find all active animations
  const activeAnimations = Object.entries(actions)
    .filter(([name, action]) => {
      // Basic check for any sign of activity
      const isActive = action && action.weight > 0 && action.enabled;

      // For strict mode, require more conditions
      return strictMode
        ? isActive &&
            action.isRunning &&
            !action.paused &&
            action.timeScale !== 0
        : isActive;
    })
    .map(([name, action]) => ({
      name,
      action,
      weight: action.weight,
      timeScale: action.timeScale,
      time: action.time,
      progress: action.getClip() ? action.time / action.getClip().duration : 0,
      isEffectivelyPlaying:
        action.isRunning &&
        !action.paused &&
        action.timeScale !== 0 &&
        action.weight > 0,
    }))
    // Sort by weight so most prominent animations come first
    .sort((a, b) => b.weight - a.weight);

  return activeAnimations;
}

/**
 * Gets the most likely current animation name based on multiple detection methods
 * @param {Object} actions - All available animation actions
 * @returns {string|null} Name of the most likely current animation or null if none detected
 */
export function getCurrentAnimationName(actions) {
  if (!actions) return null;

  // Get all animations with their stats
  const allAnimations = Object.entries(actions).map(([name, action]) => ({
    name,
    weight: action.weight,
    isRunning: action.isRunning,
    paused: action.paused,
    timeScale: action.timeScale,
    time: action.time,
    duration: action.getClip().duration,
    progress: action.time / action.getClip().duration,
    effectiveWeight: action.getEffectiveWeight(),
  }));

  // Only consider animations that are actually playing
  const runningAnimations = allAnimations.filter(
    (anim) =>
      anim.isRunning && !anim.paused && anim.timeScale !== 0 && anim.weight > 0
  );

  // Log detailed info for debugging
  console.log(
    "Animation details:",
    runningAnimations.map(
      (a) =>
        `${a.name}: w=${a.weight.toFixed(2)}, p=${(a.progress * 100).toFixed(
          0
        )}%, t=${a.time.toFixed(2)}/${a.duration.toFixed(2)}`
    )
  );

  // If we have specific walking/jump animations running, prioritize them for the JUMP->WALK case
  if (
    actions.WALKING &&
    actions.WALKING.isRunning &&
    actions.WALKING.weight > 0
  ) {
    const walkingProgress =
      actions.WALKING.time / actions.WALKING.getClip().duration;
    // If WALKING has started playing (progress > 0), prioritize it
    if (walkingProgress > 0.05) {
      return "WALKING";
    }
  }

  // If we have animations running, pick the one with most progress or highest weight
  if (runningAnimations.length > 0) {
    // Sort by progress in descending order
    const byProgress = [...runningAnimations].sort(
      (a, b) => b.progress - a.progress
    );
    // If any animation is significantly progressed, use it
    if (byProgress[0].progress > 0.1) {
      return byProgress[0].name;
    }

    // Otherwise sort by weight
    const byWeight = [...runningAnimations].sort(
      (a, b) => b.effectiveWeight - a.effectiveWeight
    );
    return byWeight[0].name;
  }

  // If nothing is running but some animations have weight, use the one with highest weight
  const withWeight = allAnimations
    .filter((a) => a.weight > 0)
    .sort((a, b) => b.weight - a.weight);

  if (withWeight.length > 0) {
    return withWeight[0].name;
  }

  return null;
}
