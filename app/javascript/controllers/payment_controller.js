import { Controller } from "stimulus"
import dropin from "braintree-web-drop-in"
import { string } from "postcss-selector-parser"

export default class extends Controller {
  static targets = ["dropin", "nonce"]
  static values = {
    token: String,
  }
  connect(){
    const form = this.element.parentNode 
    dropin
    .create({
      container: this.dropinTarget,
      authorization: this.tokenValue, 
    })
    .then((instance)=> {
      form.addEventListener('submit', (e)=> {
        e.preventDefault() 
        instance.requestPaymentMethod().then(({nonce})=> {
          this.nonceTarget.value = nonce
          form.submit()
        })
      })
    }).catch((err)=> {
      console.log("ERROR: ", err)
    })
    
     
}
}