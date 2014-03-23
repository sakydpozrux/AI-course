(defglobal
  ?*y* = y
  ?*n* = n
  ?*u* = u
)


(deffacts begin
  (beginning)
)

(defrule begin
  (beginning)
  =>
  (printout t "For each question are possible 3 answers:" crlf)
  (printout t "y, n, u (they meaning -> yes, no, unknown)" crlf)
  (printout t "You write them after the '>' symbol appears" crlf)
  (assert (questions))
)


; ---------- ;
; Questions: ;

(deffunction ask (?question)
  (printout t crlf ?question)
  (printout t crlf " > ")
)

(deffunction get_answer ()
  (bind ?answer (read))       
  (switch ?answer
    (case ?*y* then *y*)
    (case ?*n* then *n*)
    (default *u*)
  )
)

(defrule in_or_out
  (questions)
  =>
  (ask "Are you going to use rover only inside buildings (y = indoors, n = outdoors, u = both)?")
  (switch (get_answer)
    (case *y* then
      (assert (indoors)))
    (case *n* then
      (assert (outdoors)))
    (case *u* then
      (assert (indoors))
      (assert (outdoors)))
  )
)


(defrule what_weather
  (outdoors)
  =>
  (ask "Are you going to use rover during bad weather (e.g. rain)?")
  (switch (get_answer)
    (case *y* then
      (assert (bad_weather)))
    (case *n* then
      (assert (good_weather)))
    (case *u* then
      (assert (bad_weather)))
  )
)


(defrule controlled_or_autonomous
  (questions)
  =>
  (ask "Do you want to have control over the rover (y = controlled, n = autonomous, u = both)?")
  (switch (get_answer)
    (case *y* then
      (assert (control)))
    (case *n* then
      (assert (autonomous)))
    (case *u* then
      (assert (control))
      (assert (autonomous)))
  )
)


(defrule what_range
  (outdoors)
  (control)
  =>
  (ask "Is long range (> 5 km) connection with low latency necessary?")
  (switch (get_answer)
    (case *y* then
      (assert (long_range)))
    (case *n* then
      (assert (close_range)))
    (case *u* then
      (assert (medium_range)))
  )
)


(defrule if_camera
  (questions)
  =>
  (ask "Do you want rover to have an ability to record videos, take photos or have a real time video transmission from rover?")
  (switch (get_answer)
    (case *y* then
      (assert (camera)))
    (case *n* then
      (assert (no_camera)))
    (case *u* then
      (assert (camera)))
  )
)


(defrule if_darkness
  (camera)
  =>
  (ask "Are you going to sometimes use rover in dark places?")
  (switch (get_answer)
    (case *y* then
      (assert (dark)))
    (case *n* then
      (assert (bright)))
    (case *u* then
      (assert (dark)))
  )
)


(defrule if_slow
  (questions)
  =>
  (ask "Can you drive slowly?")
  (switch (get_answer)
    (case *y* then
      (assert (tracks))
      (assert (wheels)))
    (case *n* then
      (assert (wheels)))
    (case *u* then
      (assert (tracks))
      (assert (wheels)))
  )
)



(defrule if_ability_to_turn
  (wheels)
  =>
  (ask "Is ability to make a turn in place necessary?")
  (switch (get_answer)
    (case *y* then
      (assert (good_wheels))
      (assert (wheel_servos)))
  )
)


(defrule if_manipulator
  (questions)
  =>
  (ask "Do you want to grab things or move them?")
  (switch (get_answer)
    (case *y* then
      (assert (manipulator_arm))
    (case *u* then
      (assert (manipulator_arm))
  )
)


(defrule if_seen_or_unseen
  (dark)
  =>
  (ask "Can your rover be seen in dark (e.g. by other people, criminals, wild animals, ...)?")
  (switch (get_answer)
    (case *y* then
      (assert (can_be_seen)))
    (case *n* then
      (assert (cannot_be_seen)))
    (case *u* then
      (assert(can_be_seen))
      (assert(cannot_be_seen)))
  )
)


(defrule if_see_in_darkness
  (dark)
  (camera)
  =>
  (ask "Do you want your camera to see anything in the darkness?")
  (switch (get_answer)
    (case *y* then
      (assert (using_camera_in_darkness)))
    (case *u* then
      (assert (using_camera_in_darkness)))
  )
)


(defrule if_seen_by_military_drones
  (cannot_be_seen)
  =>
  (ask "Do you want to hide your rover from military drones?")
  (switch (get_answer)
    (case *y* then
      (assert (mylar))
      (assert (electric)))
    (case *n* then
      (assert (electric))
      (assert (gas_engine)))
    (case *u* then
      (assert (electric)))
  )
)


(defrule if_illegal
  (cannot_be_seen)
  =>
  (ask "Is this what you do illegal?")
  (switch (get_answer)
    (case *y* then
      (assert (call_the_police)))
    (case *u* then
      (assert (call_the_police)))
  )
)


(defrule if_far_place
  (questions)
  =>
  (ask "Do you want to go to some far place where you cant repair rover by yourself or recharge the battery (e.g. Mars)?")
  (switch (get_answer)
    (case *y* then
      (assert (far_lands)))
    (case *n* then
      (assert (close_lands))
    (case *u* then
      (assert (far_lands)))
  )
)


(defrule if_oxygen
  (questions)
  =>
  (ask "Can you use oxygen? Is there oxygen in atmosphere?")
  (switch (get_answer)
    (case *y* then
      (assert (oxygen)))
    (case *n* then
      (assert (no_oxygen)))
    (case *u* then
      (assert (no_oxygen)))
  )
)



(defrule if_nuclear_power
  (far_lands)
  =>
  (ask "Do you have a possibility to build a nuclear power plant?")
  (switch (get_answer)
    (case *y* then
      (assert (electric))
      (assert (nuclear_power))
    (case *n* then
      (assert (electric))
      (assert (solar_power)))
    (case *u* then
      (assert (electric))
      (assert (solar_power)))
  )
)


(defrule if_replicate
  (far_lands)
  (ask "Is ability to self-replicate rover necessary?")
  (switch (get_answer)
    (case *y* then
      (assert (3d-printer))
      (assert (no_metal)))
    (case *u* then
      (assert (3d-printer))
      (assert (no_metal)))
  )
)


(defrule if_climber
  (indoors)
  =>
  (ask "Do you need an ability to climb on stairs?")
  (switch (get_answer)
    (case *y* then
      (assert (stairs_servo)))
    (case *n* then
      (assert (cannot_be_seen)))
    (case *u* then
      (assert (manipulator_arm)))
  )
)





(defrule this-was-last-question
  (declare (salience -1000))
  (?q <- (questions))
  =>
  (retract ?q)
  (assert (time-for-advices))  
)



; ---------- ;
; Deduction: ;


(defrule wheels_on_hard_terrain
  (wheels)
  (hard_terrain)
  =>
  (assert (good_wheels))
)

(defrule more_sensors_if_no_camera
  (no_camera)
  =>
  (assert (many_sensors))
)

(defrule camera_darkness_seen
  (using_camera_in_darkness)
  (can_be_seen)
  =>
  (assert (torchlight))
)

(defrule camera_darkness_not_seen
  (using_camera_in_darkness)
  (cannot_be_seen)
  =>
  (assert (night_vision_device))
)

(defrule if_gas_engine_possible
  (no_oxygen)
  (?g <- (gas_engine))
  =>
  (retract ?g)
)

(defrule metal_parts_in_engine
  (no_metal)
  (?g <- (gas_engine))
  =>
  (retract ?g)
)


; -------- ;
; Advices: ;

;(defrule xxxx
; (time-for-advices)
; =>
; asd
