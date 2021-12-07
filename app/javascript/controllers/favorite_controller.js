// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>
import axios from 'lib/http/token'
import { Controller } from "stimulus"


export default class extends Controller {
  static targets = ["btn"]
  // static values = {
  //   liked: Boolean,
  //   coureseId: Number, 
  // }

  // connect(){
  //   if(this.likedValue){
  //     this.btnTarget.classList.add("favorited")
  //   }
  // }

  like() {
    const courseId = this.btnTarget.dataset.id
    //const likedBtn = this.btnTarget
    axios.post(`/api/v1/courses/${courseId}/like`).then((res)=>{
      //console.log(res.data.status)
      if (res.data.status === 'like'){
      this.btnTarget.classList.add('favorited')
    } else {
      this.btnTarget.classList.remove('favorited')
    }
    }) 
  }
} 

