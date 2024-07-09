<template>
  <div class="home row">
    <div class="wrap_section col" :style="dynamicStyles">
      <div class="content_part">
        <h2 style="color: black;margin-left: 3%;">Select Your role</h2>
        <ul>
          <li><router-link :to="{ name: 'login_admin' }" class='atag'>Admin</router-link></li>
          <li><router-link :to="{ name: 'login_manager' } " class='atag'>Manager</router-link></li>
        </ul>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "home",
  created() {
    User.logout();
  },
  computed:{
    dynamicStyles(){
        return {
            'background-image': `url(${this.imgUrl})`
        };
    }
  },
  data(){
    return{
        imgUrl:'../AdminPanel/img/home.webp',
    }
  }
};
</script>
<style>
.home {
  margin-left: 9%;

  width: 80vw;
  height: 90vh;
  margin-top: 2%;
  margin-bottom: 2%;
   position:relative;
}
.wrap_section {
    position:relative;
  text-align: center;
  background-size: cover;
}
.content_part {
  background: #83752b;
  opacity: 0.7;
  margin-top: 14rem;
  width: 70%;
  position:absolute;
  left:17%;
  padding: 1rem;
}
li {
  list-style: none;
  color: #4462d1;
  font-size: 1.2em;
  font-weight:bold;

}
.atag{
    color:white;
}
.atag:hover{
    text-decoration:none;
    color:black;
}
</style>
