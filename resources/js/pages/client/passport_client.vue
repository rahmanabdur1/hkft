<template>
  <div>
    <button type="button" class="btn action" @click="PrintContent4" style='width:100px'>Print <i class="fa fa-print pl-2" aria-hidden="true"></i
              ></button>
    <div id="print-container4" class="mt-5">
      <div class='row'>
            <div class='col-md-12'>
                <img :src="'/' + form.passport_img" class='print_img' style='width:800px;height:auto;'/>
            </div>

      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {

      form: {
        nid_img: "",
      },
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "passport_client" });
      }
    });
  },
  created() {
    if(!User.hasLoggedIn()){
      this.$router.push({name:'home'});
    }else{
      this.$router.push({name:'passport_client'});
    }
    let id = this.$route.params.id;
    axios
      .get("/api/client/" + id)
      .then(({ data }) => {
        this.form.passport_img = data.passport_img;

      })
      .catch((err) => {
      });
  },
  methods: {
    PrintContent4() {
      const printContents3 = document.getElementById("print-container4").innerHTML;
      const originalContents3 = document.body.innerHTML;
      const popupWin3 = window.open("width=800,height=800");
      popupWin3.document.open();
      popupWin3.document.write(`
        <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.45em;
              }
            .print_img{
                width:100%;
                height:auto;
            }
            </style>
          </head>
          <body onload="window.print();window.close();">${printContents3}</body>
        </html>
      `);
      popupWin3.document.close();
            this.$router.push({name:'view_client',params:{id:this.$route.params.id}});

    },
  },
};
</script>
<style >
    #print-container4 img{
        width:80%;
        height:auto;
    }
</style>
