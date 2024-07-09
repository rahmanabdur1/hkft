<template>
  <div>
    <nav>
      <h3>Before Entry any data please read this</h3>
      <h5>1. The selling price cannot be set higher then the price of the product.</h5>
      <h5>
       2.If a client pay more then the selling price of a flat Or land. The money that is extra than we have to deposit in the Extra Payment section.
      </h5>
      <h5>
       3. Must enter Flat name in creat salse section like 2D_DGC-1  / 3D_SD1.
      </h5>
      <h5>4. Must Enter Land name in unit section as 'Land ' .</h5>
      <h5>
       5. Dont try to delet any client. If anyone try to delet any client without admin permission . We will take legal action against his/her..
      </h5>
      <h5>
        6. to enter contractor name and contractor payment enter all data into the expense
        menu. use contractor name in product name section like (Nazmul _Contractor)
      </h5>
      <h5>

7. contractor details and information must be input in the employee section ( befor any contract with him)
      </h5>
      <br/>
      <h5>

To Find our other project or location visit our website : <a href="https://www.hkf-re.com">www.hkf-re.com</a>
      </h5>
      <h5>Software Version : UIC1.0.1</h5>
      <h5>Note : if need any techinical support or Modification please contact with</h5>
      <h5>UNIQUE IT CENTER: phone :01824398700 </h5>
      <h5>visit website : <a href="https://www.uniqueitcenterbd.com">www.uniqueitcenterbd.com</a></h5>
      <h5>Facebook page :<a href="https://www.facebook.com/uniqueitcenter1">https://www.facebook.com/uniqueitcenter1</a></h5>
    </nav>
  </div>
</template>
<script>
export default {
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "help" });
      }
    });
  },
};
</script>
<style>
.ledger_li {
  margin: 0.5rem;
  list-style: square;
}
.ledger_link {
  width: 100%;
  color: #605ca8 !important;
}
.ledger_link:hover {
  text-decoration: none;
  color: #3d388d !important;
}
.ledger_nav {
  display: block;
}
</style>
