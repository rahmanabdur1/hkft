<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <div class="row">
        <div class="col-md-10 mx-auto">
          <button
            type="button"
            class="btn action_print"
            style="margin-left: 85%"
            @click="printContent"
          >
            Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>

          <form>
            <div id="print-container">
              <div style="display: flex">
                <div class="sidebar-brand-icon" style="text-align: left; width: 20%">
                  <img
                    class="logo"
                    :src="'../../img/' + avatar"
                    style="width: 165%; height: 77%"
                    alt=""
                  />
                </div>
                <div style="padding: 5%; width: 80%">
                  <h3 style="text-align: center">HKF Real Estate LTD</h3>
                  <h4 style="text-align: center">
                    117/2/8 1st Floor Sopnodanga Residential Area<br />
                    Phone: 01400407270 <br />
                    Email:contact@hkf-re.com <br />
                    Website: www.hkf-re.com
                  </h4>
                </div>
              </div>
              <h2 class="mb-2" style="text-align: center; color: #605ca8">
                {{ form.clientUnderProject }}
              </h2>
              <h2 class="hkf_title mb-2" style="text-align: center">
                Building: {{ form.selectedBuilding }}
              </h2>
              <p class="hkf_title_print_only" style="color: black; text-align: center">
                {{ this.project_location }}
              </p>
              <h4
                class="hkf_title_print_only"
                style="padding: 0.5rem; color: black; text-align: center"
              >
                ব্যক্তিগত তথ্যাদিঃ
              </h4>

              <div class="row rowPhotoDiv">
                <div class="col-md-8 colPhotoDiv">
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">আইডিঃ</td>
                      <td class="td_label_data">{{ form.client_id }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">নামঃ</td>
                      <td class="td_label_data">{{ form.name }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">পিতার নামঃ</td>
                      <td class="td_label_data">{{ form.father_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">মাতার নামঃ</td>
                      <td class="td_label_data">{{ form.mother_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">স্বামি/স্ত্রীর নামঃ</td>
                      <td class="td_label_data">{{ form.husban_wife_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">জন্ম তারিখঃ</td>
                      <td class="td_label_data">{{ form.birth_date }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">ধর্মঃ</td>
                      <td class="td_label_data">{{ form.religion }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">পেশাঃ</td>
                      <td class="td_label_data">{{ form.occupation }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">জাতীয়তাঃ</td>
                      <td class="td_label_data">{{ form.nationality }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <div class="col-md-12">
                      <table
                        style="border: 1px solid black; border-collapse: collapse"
                        class="print_table"
                      >
                        <tr>
                          <th style="border: 1px solid black" class="thikana_print">
                            স্থায়ী ঠিকানা
                          </th>
                          <th style="border: 1px solid black" class="thikana_print">
                            বর্তমান ঠিকানা
                          </th>
                        </tr>
                        <tr>
                          <td
                            style="
                              border: 1px solid black;
                              background: white;
                              color: black;
                            "
                          >
                            <label class="td_label_print"
                              >গ্রাম/রোডঃ {{ form.permanent_location }},</label
                            >
                            <label class="td_label_print"
                              >ডাকঘরঃ {{ form.permanent_post_office }},</label
                            ><label class="td_label_print"
                              >থানা/উপজেলাঃ {{ form.permanent_thana }},</label
                            ><label class="td_label_print"
                              >জেলাঃ {{ form.permanent_district }}</label
                            >
                          </td>
                          <td
                            style="
                              border: 1px solid black;
                              background: white;
                              color: black;
                            "
                          >
                            <label class="td_label_print"
                              >গ্রাম/রোডঃ {{ form.temprorary_location }},</label
                            >
                            <label class="td_label_print"
                              >ডাকঘরঃ {{ form.temprorary_post_office }},</label
                            ><label class="td_label_print"
                              >থানা/উপজেলাঃ {{ form.temprorary_thana }},</label
                            ><label class="td_label_print"
                              >জেলাঃ {{ form.temprorary_district }}</label
                            >
                          </td>
                        </tr>
                      </table>
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">টি. আই. এনঃ</td>
                      <td class="td_label_data">{{ form.tin }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">মোবাইল নাম্বারঃ</td>
                      <td class="td_label_data">{{ form.phone }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">ইমেল আইডিঃ</td>
                      <td class="td_label_data">{{ form.email }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info">শেয়ার</td>
                      <td class="td_label_data">{{ form.share }}</td></label
                    >
                  </div>
                </div>
                <div class="col-md-4 colPhotoDiv">
                  <td>
                    <img class="passport_img" :src="'/' + form.profile_photos" alt="" />
                  </td>
                </div>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-6 col-form-label hkf_text_print">
                জাতীয় পরিচয়পত্রের ফটোকপিঃ</label
              >
              <router-link
                :to="{ name: 'nid_client', params: { id: this.Id } }"
                class="btn action_print"
                >Print<i class="fa fa-print pl-2" aria-hidden="true"></i
              ></router-link>
            </div>
            <div class="form-group row">
              <label class="col-sm-6 col-form-label hkf_text_print">
                পাসপোর্টের ফটোকপিঃ</label
              >
              <router-link
                :to="{ name: 'passport_client', params: { id: this.Id } }"
                class="btn action_print"
                >Print<i class="fa fa-print pl-2" aria-hidden="true"></i
              ></router-link>
            </div>

            <div class="form-group row">
              <label class="col-sm-6 col-form-label hkf_text_print"
                >টি. আই. এন ফটোকপিঃ</label
              >
              <router-link
                :to="{ name: 'tin_client', params: { id: this.Id } }"
                class="btn action_print"
                >Print<i class="fa fa-print pl-2" aria-hidden="true"></i
              ></router-link>
            </div>
          </form>
        </div>
      </div>
      <div class="col-md-6">
        <form class="form ml-5" @submit.prevent="addProperty()">
          <div class="form-group mx-sm-5 mb-2">
            <label class="hkf_text">Property Name:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Property name"
              v-model="property_search"
              @keyup="listDisplay"
            />
            <ul class="ulShow" :class="{ listStyle: list_style }">
              <li
                class="listShow"
                :class="{ listStyle: list_style }"
                v-for="(item, index) in filterInventory"
                :key="index"
                :value="item.property_name"
                @click="assignToSearch(item)"
              >
                {{ item.property_name }}
              </li>
            </ul>
          </div>
          <div>
            <div class="flat-grid col-md-12">
              <!-- Dynamically render input fields using v-for -->
              <div
                v-for="(value, index) in flat_items"
                :key="index"
                class="input-wrapper ml-5"
                style="display: flex; padding: 0.3em"
              >
                <span>{{ flat_items[index].property_name }}</span>

                <i class="fa fa-trash ml-2" @click="removeFlat(index)"></i>
              </div>
            </div>
          </div>
          <button type="submit" class="btn btn-primary mb-2">Save</button>
        </form>
      </div>
      <!-- button -->
      <div class="btn-group btn-group-toggle ml-5 mt-3" data-toggle="buttons">
        <label class="btn" :class="{ tglBtn1: clickclient }">
          <input
            type="radio"
            name="options"
            id="option1"
            autocomplete="off"
            @click="option1"
          />
          Before Construction
        </label>
        <label class="btn" :class="{ tglBtn2: clickConstruction }">
          <input
            type="radio"
            name="options"
            id="option2"
            autocomplete="off"
            @click="option2"
          />
          In Construction Period
        </label>
      </div>
      <!--end-->
      <div class="row mt-5" v-if="isAdmin && clickclient">
        <table class="table">
          <thead>
            <tr>
              <th>SL</th>
              <th>Client Name</th>
              <th>Project Name</th>
              <th>Building Name</th>

              <th>Product Name</th>

              <th>Product Amount</th>
              <th>Paid Amount</th>
              <th>Due Amount</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(reference, index) in client_projects" :key="reference.id">
              <td>{{ ++index }}</td>
              <td>{{ reference.client_name }}</td>
              <td>{{ reference.selectedProject }}</td>
              <td v-if="reference.building_name">{{ reference.building_name }}</td>
              <td v-else>Land</td>
              <td>{{ reference.product_name }}</td>
              <td>{{ reference.product_amount }} tk</td>
              <td>{{ reference.total_amount }} tk</td>
              <td>{{ reference.due }} tk</td>
            </tr>

            <!-- add more rows as needed -->
          </tbody>

          <!-- <div class='pagination'>
      <ul v-if="lastPage > 1">
      <li v-for="page in lastPage" :key="page" :class="{ 'active': page === currentPage }">
        <router-link :to="{name:'account_type'}" @click.prevent="setPage(page)">{{ page }}</router-link>
      </li>
    </ul>
    </div> -->
        </table>
      </div>
      <div class="row mt-5" v-if="isAdmin && clickConstruction">
        <table class="table">
          <thead>
            <tr>
              <th>SL</th>
              <th>Client Name</th>
              <th>ID</th>
              <th>Properties</th>
              <th>Required Amount</th>
              <th>Paid Amount</th>
              <th>Due Amount</th>
              <th>Advance</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(reference, index) in client_constructions" :key="reference.id">
              <td>{{ ++index }}</td>
              <td>{{ reference.client_name }}</td>
              <td>{{ reference.client_id }}</td>

              <td v-if="reference.property_name">
                {{ removeLastComma(reference.property_name) }}
              </td>
              <td v-else>
                {{ reference.share }}
              </td>
              <td>{{ reference.required_amount }} tk</td>
              <td>{{ reference.paid_amount }} tk</td>
              <td>{{ reference.due_amount }} tk</td>
              <td v-if="reference.extra">{{ reference.extra }}tk</td>
              <td v-else>0 tk</td>
            </tr>

            <!-- add more rows as needed -->
          </tbody>

          <!-- <div class='pagination'>
      <ul v-if="lastPage > 1">
      <li v-for="page in lastPage" :key="page" :class="{ 'active': page === currentPage }">
        <router-link :to="{name:'account_type'}" @click.prevent="setPage(page)">{{ page }}</router-link>
      </li>
    </ul>
    </div> -->
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  name: "view_client",
  data() {
    return {
      avatar: "logo.png",
      form: {
        client_id: "",
        selectedProject: "",
        selectedBuilding: "",
      },
      data: {
        building_name: "",
      },
      client_constructions: [],
      flat_items: [],
      properties: [],
      buildings: [],
      project_location: "",
      projects_temp: [],
      Id: "",
      client_projects: [],
      isAdmin: false,
      property_search: "",
      list_style: true,
      clicked: [],
      clickConstruction: false,
      clickclient: false,
    };
  },
  computed: {
    filterInventory() {
      this.clicked = this.properties.filter((item) => {
        for (let flat of this.flat_items) {
          if (flat.property_name === item.property_name) {
            return false;
          }
        }
        return true;
      });
      return this.clicked.filter((product) => {
        let product_name = this.property_search.toUpperCase();
        let inventory_name = product.property_name.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
  },
  methods: {
    removeLastComma(propertyName) {
      if (propertyName.endsWith(",")) {
        return propertyName.slice(0, -1);
      } else {
        return propertyName;
      }
    },
    addProperty() {
      axios
        .patch("/api/fill_voucher_by_property/" + this.form.client_id, this.flat_items)
        .then((res) => {
          console.log(res.data);
          // this.$router.push({ name: "all_client" });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    option1() {
      this.clickclient = true;
      this.clickConstruction = false;
    },
    option2() {
      this.clickclient = false;
      this.clickConstruction = true;
    },
    removeFlat(index) {
      this.flat_items.splice(index, 1); // Remove the flat value at the specified index
    },
    assignToSearch(item) {
      this.list_style = true;
      this.property_search = "";
      this.flat_items.push(item);
    },

    printContent() {
      const printContents = document.getElementById("print-container").innerHTML;
      const originalContents = document.body.innerHTML;
      const popupWin = window.open("width=800,height=800");
      popupWin.document.open();
      popupWin.document.write(`
        <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.25rem;
              }
              .rowPhotoDiv {
                width: 100%;
                display:flex;
              }
              .colPhotoDiv {
                width: 50%;
              }
              .passport_img {
                margin-left:25%;
                width: 120px;
                height: 160px;
                margin-top:-15%;
              }
              .thikana_print{
                border-bottom:1px solid black;
                font-size:1.1em;
              }
             td{
              margin:0.5em;
             }
             .td_label_print {
                padding-right: 0.25rem;;
                width:100%;
              }
              .td_label_data {
                 margin-right: 0.5rem;
                }
                label{
                  padding:.5rem;
                }
                .print_table {

                   width:650px;
                }
                .print_table td {
                  padding: 0.5rem 0rem 0.5rem 1rem;
}
               .hkf_title_print_only{
                 margin-top:-1%;
                  color: black ;
                  text-align: center;
                }
            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({ name: "view_client", params: { id: this.$route.params.id } });
    },
    listDisplay() {
      this.list_style = false;
    },
  },
  created() {
    let id = this.$route.params.id;
    this.Id = id;
    axios
      .get("/api/get_client_project/" + id)
      .then((res) => {
        this.form.client_id = res.data.client_id;
        this.form.selectedProject = res.data.clientUnderProject;
        this.form.selectedBuilding = res.data.selectedBuilding;
        axios
          .get("/api/fetch_client_property_name/" + this.form.selectedBuilding)
          .then((res) => {
            this.properties = res.data;
            console.log(res.data);
          })
          .catch((err) => {
            console.log(err.response);
          });
        axios
          .get("/api/fetch_client_construction/" + this.form.client_id)
          .then((res) => {
            this.client_constructions = res.data;
            console.log(this.client_constructions);
          })
          .catch((err) => {
            console.log(err.response);
          });
      })
      .catch((err) => {
        console.log(err.response);
      });
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "view_client" });
    }

    this.guard = User.getGuard();
    if (this.guard == "admin") {
      this.isAdmin = true;
      axios
        .get("/api/client/" + id)
        .then(({ data }) => {
          this.form = data;
          console.log(this.form);
          axios.get("/api/getClientAllProject/" + this.form.client_id).then((res) => {
            this.client_projects = res.data;
            console.log(res.data);
          });
        })
        .catch((err) => {});
    }
    axios
      .get("/api/project")
      .then((res) => {
        this.projects_temp = res.data;
        this.projects_temp.forEach((item) => {
          if (item.project_name == this.form.clientUnderProject) {
            this.project_location = item.project_address;
          }
        });
      })
      .catch((err) => {});
  },
};
</script>
<style>
.tglBtn1 {
  background: #5d57c3;
  color: white;
}
.tglBtn2 {
  background: #5d57c3;
  color: white;
}
.flat-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
}
.thikana_print {
  color: black !important;
  background: white;
  margin-left: 20%;
  margin-bottom: 2rem;
  text-align: center;
  padding: 0.5rem;
}
.action_print {
  color: white;
  background: #5d57c3;
  padding: 5px;
  width: 90px;
}
.td_label_print {
  padding-right: 1em;
  width: 100%;
}
.td_label_data {
  color: black !important;
  margin-right: 0.5rem;
}
.passport_img {
  width: 150px;
  height: 150px;
}
.print-container {
  margin-top: 1rem;
}
.print_table {
  min-width: 400px;
  width: 590px;
}
.print_table td {
  padding: 0.5rem 0rem 0.5rem 1rem;
}
.hkf_text_print {
  color: black;
}
.td_label_info {
  padding-right: 0.5rem;
}
@media print {
  .rowPhotoDiv {
    width: 100%;
  }
  .colPhotoDiv {
    width: 50%;
  }
  .passport_img {
    width: 120px;
    height: 90px;
  }
  .hkf_title_print_only {
    padding: 0.5rem;
    color: black;
    text-align: center;
  }
}
</style>
