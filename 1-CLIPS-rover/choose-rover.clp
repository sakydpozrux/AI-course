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
  (printout t "y, n, u (they are meaning -> yes, no, unknown)" crlf)
  (printout t "You write them after the '>' symbol appears" crlf)
  (assert (questions))
)


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



; ---------- ;
; Questions: ;


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
  (ask "Are you going to use rover in dark places sometimes?")
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
      (assert (manipulator_arm)))
    (case *u* then
      (assert (manipulator_arm)))
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
      (assert (close_lands)))
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
      (assert (nuclear_power)))
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
  =>
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
  (questions)
  ?q <- (questions)
  =>
  (retract ?q)
  (assert (time-for-advices))  
  (printout t crlf crlf)
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
  (gas_engine)
  ?g <- (gas_engine)
  =>
  (retract ?g)
)

(defrule metal_parts_in_engine
  (no_metal)
  (gas_engine)
  ?g <- (gas_engine)
  =>
  (retract ?g)
)


; -------- ;
; Advices: ;

(deffunction advice (?what)
  (printout t ?what crlf)
)


(defrule adv-bad_weather
  (time-for-advices)
  (bad_weather)
  =>
  (advice "Because rover may be used during bad weather - you should consider using better quality materials to build the frame.")
)

(defrule adv-autonomous
  (time-for-advices)
  (autonomous)
  =>
  (advice "You have to know something about Artifical Intelligence. Better read few books before starting programming.")
)

(defrule adv-control
  (time-for-advices)
  (control)
  =>
  (advice "You need to design GUI for rover control software and choose appriopriate transmission devices.")
)

(defrule adv-control-autonomous
  (time-for-advices)
  (control)
  (autonomous)
  =>
  (advice "There are many programming tasks. Consider hiring at least 2 programmmers.")
)

(defrule adv-long-range
  (time-for-advices)
  (long_range)
  =>
  (advice "For long range communication consider using RF technology or WiFi with good quality directional antenna.")
)

(defrule adv-medium-range
  (time-for-advices)
  (medium_range)
  =>
  (advice "For mid-range transmission WiFi with good omnidirectional antenna should be enough.")
)

(defrule adv-close-range
  (time-for-advices)
  (close_range)
  =>
  (advice "For close range communication you can use cheap omnidirectional antenna and WiFi technology.")
)

(defrule adv-mylar-legal
  (time-for-advices)
  (mylar)
  (not (call_the_police))
  =>
  (advice "I trust you it's fully legal business. Consider using mylar fiber to be invisible for criminals night vision devices.")
)

(defrule adv-mylar-illegal
  (time-for-advices)
  (mylar)
  (call_the_police)
  =>
  (advice "I see it's very strange project. To reflect heat you can use mylar fiber. Spy drones won't see you and your rover doing bad things.")
)

(defrule adv-police
  (time-for-advices)
  (call_the_police)
  =>
  (advice "I'm also calling police right now because of your illegal plans. Better hide.")
)

(defrule adv-mylar
  (time-for-advices)
  (mylar)
  =>
  (advice "I see it's very strange project. To reflect heat you can use mylar fiber. Spy drones won't see your rover.")
)

(defrule adv-3d-printer
  (time-for-advices)
  (3d-printer)
  =>
  (advice "To replicate you need something like 3D-printer.")
)

(defrule adv-no-metal
  (time-for-advices)
  (no_metal)
  =>
  (advice "Unfortunately current technology doesn't allow us to replicate things with metal elements. You should build rover from only plastic things.")
)

(defrule adv-oxygen
  (time-for-advices)
  (oxygen)
  =>
  (advice "If there will be oxygen - great! You probably can grow plants and make even more oxygen.")
)

(defrule adv-no-oxygen
  (time-for-advices)
  (no_oxygen)
  =>
  (advice "If you won't find oxygen - your rover won't breathe. In particular your gas engine won't work if you want to use on. Elecricity is better.")
)

(defrule adv-gas-engine
  (time-for-advices)
  (gas_engine)
  =>
  (advice "Looks like you can try gas engine.")
)

(defrule adv-electric
  (time-for-advices)
  (electric)
  =>
  (advice "Electric engine fits good.")
)

(defrule adv-turn-wheels
  (time-for-advices)
  (turn)
  (wheels)
  =>
  (advice "To make a full turn in place you can't use wheels with thin tread. Using broad one would be reasonable.")
)

(defrule adv-turn-tracks
  (time-for-advices)
  (turn)
  (tracks)
  =>
  (advice "You can make a full turn with almost every pair of tracks you can use.")
)

(defrule adv-nuclear-power
  (time-for-advices)
  (nuclear_power)
  =>
  (advice "Nuclear power is great in such projects if you are able to get it. Your rover will work a dozen of years before discharge.")
)

(defrule adv-solar-power
  (time-for-advices)
  (solar_power)
  =>
  (advice "You can also power your rover by solar power.")
)

(defrule adv-good-wheels
  (time-for-advices)
  (good_wheels)
  =>
  (advice "Better buy good quality wheels.")
)

(defrule adv-wheel-servos
  (time-for-advices)
  (wheel_servos)
  =>
  (advice "Small servoengines would be helpful to make a turn. Consider buying at least 2.")
)

(defrule adv-stairs-servo
  (time-for-advices)
  (stairs_servo)
  =>
  (advice "If you want to climb stairs you should use an additional arm to help your rover in doing this.")
)

(defrule adv-manipulator-arm
  (time-for-advices)
  (manipulator_arm)
  =>
  (advice "With manipulator arm you can grab things and move them. You can try it also to climb stairs.")
)

(defrule adv-wheels
  (time-for-advices)
  (wheels)
  =>
  (advice "You can use wheels.")
)

(defrule adv-tracks
  (time-for-advices)
  (tracks)
  =>
  (advice "You may find tracks appriopriate for your task.")
)

(defrule adv-far-lands
  (time-for-advices)
  (far_lands)
  =>
  (advice "You may encounter various problems with connection (disconnections and delay) when rover will be far from you. Test your connectivity before using your rover in practice.")
)

(defrule adv-many-sensors
  (time-for-advices)
  (many_sensors)
  =>
  (advice "The rover should be equiped with many sensors.")
)

(defrule adv-using-camera-in-darkness
  (time-for-advices)
  (using_camera_in_darkness)
  =>
  (advice "Buy tested cameras only with good optics. It will be necessary to have at least one good quality camera in darkness.")
)

(defrule adv-torchlight
  (time-for-advices)
  (torchlight)
  =>
  (advice "Equip your rover with simple torchlight.")
)

(defrule adv-night_vision_device
  (time-for-advices)
  (night_vision_device)
  =>
  (advice "You don't want to be seen so night vision device also seems to be good advice.")
)

(defrule adv-no_camera
  (time-for-advices)
  (no_camera)
  =>
  (advice "It seems that camera is redundant in your project. You don't have to equip your robot with it.")
)



