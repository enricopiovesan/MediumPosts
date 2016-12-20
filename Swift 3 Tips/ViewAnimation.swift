extension UIView {
   func pushTransition(duration:CFTimeInterval) {
      let animation:CATransition = CATransition()
      animation.timingFunction = CAMediaTimingFunction(name:
         kCAMediaTimingFunctionEaseInEaseOut)
      animation.type = kCATransitionPush
      animation.subtype = kCATransitionFromTop
      animation.duration = duration
      self.layer.addAnimation(animation, forKey: kCATransitionPush)
   
   }
}