<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Create Cash/Cheque Receipt</h2>

    <div class="row">
      <div class="col-md-12">
        <form
          class="form"
          @submit.prevent="receiveVoucher()"
          enctype="multipart/form-data"
        >
          <div class="row box_container">
            <div class="col-md-5 formBox">
              <h4 class="hkf_title">Basic Information:</h4>
              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Select Financial Year</label>
                <select
                  class="form-control"
                  id="mySelect"
                  name="status"
                  v-model="form.financialYear"
                  required
                >
                  <option
                    v-for="(range, index) in yearRanges"
                    :value="range"
                    :key="index"
                  >
                    {{ range }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="form.basic_date"
                  required
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Receipt Type</label>
                <select
                  class="form-control"
                  id="mySelect"
                  name="status"
                  v-model="form.selectedPaymentType"
                  @change="choosePaymentType"
                  required
                >
                  <option
                    v-for="(payment, index) in payment_types"
                    :key="index"
                    :value="payment.payment_type"
                  >
                    {{ payment.label }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="showBankField">
                <label class="hkf_text">Cash/Bank Account</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Cash/Bank Account"
                  v-model="form.cash_bank_account"
                />
              </div>
            </div>
            <div class="col-md-5 formBox depositorBox">
              <h4 class="hkf_title">Depositor's Information:</h4>
              <div class="form-group">
                <label class="col-form-label hkf_text">Select Depositors Type</label>
                <div>
                  <select
                    class="form-control status"
                    id="mySelect"
                    v-model="client.statuses"
                    @change="checkClient"
                  >
                    <option
                      v-for="(client, index) in clientStatus"
                      :key="index"
                      :value="client.status"
                    >
                      {{ client.status }}
                    </option>
                  </select>
                </div>
              </div>

              <div class="form-group mx-sm-3 mb-2" v-if="client_not_exist">
                <label for="projectName" class="hkf_text">Depositor</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Depositors Name,Name,Phone"
                  required
                  v-model="form.client_name"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="client_exist">
                <label for="projectName" class="hkf_text">Depositors Name</label>
                <div style="display: flex">
                  <input
                    type="text"
                    class="form-control status"
                    placeholder="Client ID"
                    v-model="client_search"
                    @keyup="listDisplayClient"
                  />
                </div>
                <div>
                  <ul class="ulShow" :class="{ listStyle: list_client_style }">
                    <li
                      class="listShow"
                      :class="{ listStyle: list_client_style }"
                      v-for="(item, index) in filterSearch"
                      :key="index"
                      :value="item.client_id"
                      @click="assignToSearchClient(item)"
                    >
                      {{ item.name }}
                    </li>
                  </ul>
                </div>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="isAdmin">
                <label for="projectName" class="hkf_text">Select Product Type</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.property_type"
                  @change="chooseProductType"
                  required
                >
                  <option
                    v-for="(project, index) in product_types"
                    :key="index"
                    :value="project.value"
                  >
                    {{ project.label }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="isManager">
                <label for="projectName" class="hkf_text">Select Product Type</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.property_type"
                  @change="chooseProductType"
                  required
                >
                  <option
                    v-for="(project, index) in product_types_manager"
                    :key="index"
                    :value="project.value"
                  >
                    {{ project.label }}
                  </option>
                </select>
              </div>
              <!-- dfd -->
              <div class="form-group mx-sm-3 mb-2" v-if="client_exist && isProject">
                <label for="projectName" class="hkf_text">Select Project</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.selectedProject"
                  required
                  @change="chooseProject"
                >
                  <option
                    v-for="(project, index) in registeredProject"
                    :key="index"
                    :value="project.clientUnderProject"
                  >
                    {{ project.clientUnderProject }}
                  </option>
                </select>
              </div>

              <!-- -->
              <!-- 2nd-->
              <div
                class="form-group mx-sm-3 mb-2"
                v-if="client_not_exist && isProject && isAdmin"
              >
                <label for="projectName" class="hkf_text">Select Project</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.selectedProject"
                  onfocus="this.size=10"
                  onblur="this.size=1"
                  onchange="this.size=1;this.blur();"
                  @change="chooseProject"
                  required
                >
                  <option
                    v-for="(project, index) in allProjects"
                    :key="index"
                    :value="project.project_name"
                  >
                    {{ project.project_name }}
                  </option>
                </select>
              </div>
              <div
                class="form-group mx-sm-3 mb-2"
                v-if="client_not_exist && isProject && isManager"
              >
                <label for="projectName" class="hkf_text">Select Project</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.selectedProject"
                  onfocus="this.size=10"
                  onblur="this.size=1"
                  onchange="this.size=1;this.blur();"
                  @change="chooseProject"
                  required
                >
                  <option
                    v-for="(project, index) in projects"
                    :key="index"
                    :value="project.project"
                  >
                    {{ project.project }}
                  </option>
                </select>
              </div>
              <!-- -->
              <div class="form-group mx-sm-3 mb-2" v-if="isBuildingExist">
                <label for="projectName" class="hkf_text"
                  >Select Building {{ this.form.building_name }}</label
                >
                <select
                  class="form-control status"
                  id="mySelect"
                  v-model="form.building_name"
                  @change="selectBuilding"
                  onfocus="this.size=5"
                  onblur="this.size=1"
                  onchange="this.size=1;this.blur();"
                >
                  <option
                    v-for="(item, index) in all_building"
                    :key="index"
                    :value="item.building_name"
                  >
                    {{ item.building_name }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="isLabel">
                <label for="projectName" class="hkf_text">Select Label</label>
                <select
                  class="form-control status"
                  id="mySelect"
                  v-model="form.selected_label"
                  required
                  @change="chooseLabel"
                >
                  <option
                    v-for="(project, index) in labels"
                    :key="index"
                    :value="project.value"
                  >
                    {{ project.label }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Inventory Name:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Inventory name"
                  v-model="product_search"
                  @keyup="listDisplay"
                  required
                />
                <ul class="ulShow" :class="{ listStyle: list_style }">
                  <li class="listShow" @click="notSelected()">Not Selected</li>
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
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Depositors mobile no:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="mobile no"
                  v-model="form.client_phone"
                  required
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Depositors Email:</label>
                <input
                  type="email"
                  class="form-control"
                  placeholder="email"
                  v-model="form.client_email"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Depositors Tin:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="tin"
                  v-model="form.client_tin"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Receiver Name:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Receiver Name"
                  v-model="form.received_by"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text"
                  >Property Total Amount: {{ form.product_amount }} tk</label
                >
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Due Amount: {{ form.due }} tk</label>
              </div>
              <div class="form-group" v-if="isAdmin">
                <label class="col-form-label hkf_text">Reference</label>
                <div>
                  <select
                    class="form-control status"
                    id="mySelect"
                    v-model="reference_status"
                    @change="checkReference"
                  >
                    <option
                      v-for="(reference, index) in allowReference"
                      :key="index"
                      :value="reference.value"
                    >
                      {{ reference.label }}
                    </option>
                  </select>
                </div>
              </div>
              <div v-if="hasReference && isAdmin">
                <div class="form-group mx-sm-3 mb-2">
                  <label class="hkf_text">Reference ID: {{ ReferenceName }}</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Reference ID"
                    v-model="reference_search"
                    @keyup="ReferenceList"
                    required
                  />
                  <ul class="ulShow" :class="{ listStyle: reference_list_style }">
                    <li
                      class="listShow"
                      :class="{ listStyle: reference_list_style }"
                      v-for="(item, index) in filterReference"
                      :key="index"
                      :value="item.reference_id"
                      @click="assignReferenceToSearch(item)"
                    >
                      {{ item.reference_id }}
                    </li>
                  </ul>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                  <label class="hkf_text">Reference Amount:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Amount"
                    v-model="reference_form.reference_amount"
                    required
                  />
                </div>
              </div>
            </div>
            <div class="row formBox mx-auto cashSection" v-if="bankChoose">
              <div class="col-md-12">
                <h4 class="hkf_title" style="border: none">
                  Received Cheque Details Information:
                </h4>
              </div>
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">Cheque No.</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Cheque no"
                    v-model="form.bank_cheque_no"
                    required
                  />
                </div>
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">Cheque Date</label>
                  <input
                    type="date"
                    class="form-control"
                    placeholder="Enter Cheque Date"
                    v-model="form.bank_cheque_date"
                    required
                  />
                </div>
              </div>

              <div class="row additionalPart">
                <div class="col-md-6">
                  <label class="hkf_text">Issuing Bank Name</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Enter Issuing Bank Name"
                    v-model="form.bank_name"
                    required
                  />
                </div>
                <div class="col-md-6">
                  <label class="hkf_text">Issuing Branch Name</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Enter Issuing Branch Name"
                    v-model="form.bank_branch"
                  />
                </div>
              </div>
            </div>
            <div class="row formBox mx-auto cashSection" v-if="bankChoose">
              <div class="col-md-12">
                <h4 class="hkf_title" style="border: none">Pay Order:</h4>
              </div>
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">Pay to</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="payee's name"
                    v-model="form.payto"
                  />
                </div>
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">payorder number</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="payorder number.."
                    v-model="form.payees_account_no"
                  />
                </div>
              </div>
            </div>
            <div class="row formBox mx-auto cashSection">
              <div style="display: block; width: 300px; margin-left: 50px">
                <label class="hkf_text">Total Paid: {{ parseInt(total_paid) }}tk</label>
              </div>
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">Received Amount</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Received amount.."
                    v-model="form.total_amount"
                    required
                    @keyup="calculateDue"
                  />
                </div>
                <div class="form-group col-md-6">
                  <label class="hkf_text">Receiver Name:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Receiver Name"
                    v-model="form.received_by"
                  />
                </div>
              </div>

              <div class="row additionalPart">
                <div class="col-md-6">
                  <label class="hkf_text">Payment Details (Narration)</label>
                  <input
                    type="text"
                    class="form-control col-md-8"
                    placeholder="Enter Payment Details(Narration)..."
                    v-model="form.payment_receipt_details"
                  />
                </div>
                <div class="col-md-6" style="padding: 1rem">
                  <label class="hkf_text">Attach File</label>
                  <input
                    type="file"
                    class="col-md-8"
                    placeholder="Enter Payment Details(Narration)..."
                    @change="selectedDocs"
                  />
                  <embed
                    v-if="selectedDocs"
                    :src="Supporting_docs"
                    type="application/pdf"
                  />
                </div>
              </div>
            </div>
          </div>

          <button type="submit" class="btn btn-primary mb-2" v-if="showButton">
            Save
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "add_account_type",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        axios.get("/api/fetch_access/" + User.getUserName()).then((res) => {
          if (User.getUserName() != res.data.manager_name) {
            vm.$router.push({ name: "manager_dashboard" });
          }
        });
      } else {
        vm.$router.push({ name: "edit_voucher" });
      }
    });
  },

  data() {
    return {
      isBuildingExist: false,
      isLabel: false,
      product_types: [
        { value: "land", label: "Land" },
        { value: "others", label: "Building" },
      ],
      product_types_manager: [{ value: "others", label: "Building" }],
      client_search: "",
      list_client_style: true,

      client_not_exist: true,
      client_exist: false,
      allClients: [],
      allProjects: [],
      client: {
        statuses: "",
        name: "",
      },
      showButton: true,
      ReferenceName: "",
      list_style: true,
      isProject: false,
      inventories: [],
      list_style_category_id: true,
      list_style_category_name: true,
      selectedClient: null,
      registeredProject: [],
      client_nid: "",
      clientStatus: [{ status: "Exist" }, { status: "New" }],
      bankChoose: false,
      category_name_search: "",
      category_id_search: "",

      form: {
        received_by: "",
        financialYear: "",
        basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        client_name: "",
        selectedProject: "",
        client_tin: "",
        client_email: "",
        client_phone: "",
        product_name: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        total_amount: "",
        receipt_id: "",
        payto: "",
        payees_account_no: "",
        property_type: "",
        client_id: "",
        payment_receipt_details: "",
        Supporting_docs: "",
        product_amount: "",
        due: "",
        building_name: "",
        selected_label: "",
        property_id: "",
        account_type: "",
        sub_property_id: "",

        old_label: "",
        old_property_id: "",
        old_sub_property_id: "",
        old_owner: "",
        old_property_type: "",
      },
      all_building: "",
      labels: [
        { value: "all", label: "All" },
        { value: "floor", label: "Floor" },
        { value: "flat", label: "Flat" },
        { value: "shop", label: "Shop" },
      ],
      total_paid: "",
      product_search: "",
      Supporting_docs: "",
      showBankField: false,
      payment_types: [
        { payment_type: "Cash", label: "Cash" },
        { payment_type: "Cheque", label: "Cheque" },
      ],
      old_property: "",
      hasReference: false,
      reference_list_style: true,

      allowReference: [
        { label: "Yes", value: "Yes" },
        { label: "No", value: "No" },
      ],
      reference_form: {
        reference_name: "",
        reference_id: "",
        product_name: "",
        date: "",
        reference_amount: "",
        client_name: "",
        voucher_no: "",
      },
      isAdmin: false,
      isManager: false,
      reference_status: "",
      all_references: [],
      reference_search: "",
      not_selected: false,
    };
  },

  created() {
    //client
    if (User.getGuard() == "admin") {
      axios.get("/api/client").then((res) => {
        this.allClients = res.data;
      });
    } else if (User.getGuard() == "manager") {
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          console.log(res.data);
          const promises = [];

          res.data.forEach((item) => {
            promises.push(
              axios.get("/api/getManagerProjectClient/" + item.project).then((res) => {
                return res.data;
              })
            );
          });
          Promise.all(promises).then((res) => {
            this.allClients = res.flat();
            console.log(this.allClients);
          });
        })
        .catch((err) => {});
    }
    /// start
    //change

    //

    //admin  & manager
    this.guard = User.getGuard();
    if (this.guard == "admin") {
      this.isAdmin = true;
      this.isManager = false;
      axios
        .get("/api/project")
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {});
    } else if (this.guard == "manager") {
      this.isManager = true;
      this.isAdmin = false;
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          this.projects = res.data;
        })
        .catch((err) => {});
    }

    //end

    //receipt _edit

    let id = this.$route.params.id;
    axios
      .get("/api/receipt_voucher/" + id)
      .then((res) => {
        this.form = res.data;
        this.product_search = this.form.product_name;
        this.old_property = this.form.product_name;
        this.form.old_label = res.data.selected_label;
        this.form.old_sub_property_id = res.data.sub_property_id;
        this.reference_form.voucher_no = res.data.receipt_id;
        this.form.old_property_id = res.data.property_id;
        this.form.old_owner = res.data.client_name;
        this.form.old_property_type = res.data.property_type;
        this.total_paid = res.data.total_amount;
        this.form.total_amount = "";
        if (this.form.property_type.toLowerCase() != "land") {
          this.isProject = true;
          this.isBuildingExist = true;
          this.isLabel = true;
        } else if (this.form.property_type.toLowerCase() == "land") {
          this.isProject = false;
          this.isBuildingExist = false;
          this.isLabel = false;
        }
        axios
          .get("/api/getReference/" + this.form.receipt_id)
          .then((res) => {
            if (res.data.reference_name != undefined || res.data.reference_name != null) {
              this.hasReference = true;
              this.reference_form = res.data;
              this.reference_search = res.data.reference_id;
              this.ReferenceName = res.data.reference_name;
            } else {
              this.hasReference = false;
            }
          })
          .catch((err) => {});
        if (this.form.building_name != "") {
          axios
            .post("/api/filterProductType", this.form, {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            })
            .then((res) => {
              this.inventories = res.data;
              axios
                .post("/api/getBuildingName", this.form, {
                  headers: {
                    "Content-Type": "application/json",
                    Accept: "application/json",
                  },
                })
                .then((res) => {
                  this.all_building = res.data;
                  if (this.all_building != "") {
                    this.isBuildingExist = true;
                  } else {
                    this.isBuildingExist = false;
                  }
                })
                .catch((err) => {});
            })
            .catch((err) => {});
        }
      })
      .catch((err) => {});

    axios
      .get("/api/client")
      .then((res) => {
        this.allClients = res.data;
      })
      .catch((err) => {});

    this.chooseProductTypeMethods();
    this.loadBankAccount();
  },
  methods: {
    listDisplayCategoryId() {
      this.list_style_category_id = false;
    },
    listDisplayCategoryName() {
      this.list_style_category_name = false;
    },
    notSelected() {
      this.not_selected = true;
      this.product_search = "Not Selected";
      this.list_style = true;
      this.form.product_name = this.product_search;
      console.log(this.product_search);
    },
    listDisplayClient() {
      this.list_client_style = false;
    },
    assignToSearchClient(item) {
      this.client_search = item.client_id;
      this.form.client_name = item.name;
      this.form.client_phone = item.phone;
      this.form.client_tin = item.tin;
      this.form.client_email = item.email;
      this.form.client_id = item.client_id;
      this.client_nid = item.national_id_no;
      this.list_client_style = true;
      axios
        .get("/api/fetch_client_project/" + this.client_search)
        .then((res) => {
          this.registeredProject = res.data;
          console.log(res.data);
        })
        .catch((err) => {});
    },
    loadBankAccount() {
      setTimeout(() => {
        if (this.form.selectedPaymentType == "Cheque") {
          this.showBankField = true;
          this.bankChoose = true;
        } else {
          this.showBankField = false;
          this.bankChoose = false;
        }
      }, 1000);
    },
    receiveVoucher() {
      //receipt_account

      //receipt_voucher

      let id = this.$route.params.id;
      const formData = new FormData();
      formData.append("financialYear", this.form.financialYear);
      formData.append("basic_date", this.form.basic_date);
      formData.append("selectedPaymentType", this.form.selectedPaymentType);
      formData.append("cash_bank_account", this.form.cash_bank_account);
      formData.append("client_name", this.form.client_name);
      formData.append("selectedProject", this.form.selectedProject);
      formData.append("client_tin", this.form.client_tin);
      formData.append("client_email", this.form.client_email);
      formData.append("client_phone", this.form.client_phone);
      formData.append("product_name", this.form.product_name);
      formData.append("due", this.form.due);
      formData.append("product_amount", this.form.product_amount);
      formData.append("bank_cheque_no", this.form.bank_cheque_no);
      formData.append("bank_cheque_date", this.form.bank_cheque_date);
      formData.append("bank_name", this.form.bank_name);
      formData.append("bank_branch", this.form.bank_branch);
      formData.append("total_amount", this.form.total_amount);
      formData.append("receipt_id", this.form.receipt_id);
      formData.append("payto", this.form.payto);
      formData.append("payees_account_no", this.form.payees_account_no);
      formData.append("Supporting_docs", this.form.Supporting_docs);
      formData.append("client_id", this.form.client_id);
      formData.append("payment_receipt_details", this.form.payment_receipt_details);
      formData.append("id", id);
      formData.append("building_name", this.form.building_name);
      formData.append("selected_label", this.form.selected_label);
      formData.append("property_id", this.form.property_id);
      formData.append("sub_property_id", this.form.sub_property_id);
      formData.append("account_type", this.form.account_type);
      formData.append("old_label", this.form.old_label);
      formData.append("old_property_id", this.form.old_property_id);
      formData.append("old_sub_property_id", this.form.old_sub_property_id);
      formData.append("old_owner", this.form.old_owner);
      formData.append("old_property_type", this.form.old_property_type);
      formData.append("property_type", this.form.property_type);
      formData.append("old_properties", this.old_property);

      this.reference_form.date = this.form.basic_date;
      this.reference_form.client_name = this.form.client_name;
      this.reference_form.product_name = this.form.product_name;
      this.reference_form.voucher_no = this.form.receipt_id;
      if (this.hasReference) {
        axios
          .patch(
            "/api/reference/" + this.reference_form.voucher_no,
            this.reference_form,
            {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            }
          )
          .then((res) => {})
          .catch((err) => {});
      }
      axios
        .post("/api/receipt_voucher_update", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_voucher" });
        })
        .catch((err) => {});
    },

    selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.Supporting_docs = file;
      };

      reader.readAsDataURL(file);
    },
    listDisplay() {
      this.list_style = false;
    },
    assignToSearch(item) {
      this.not_selected = false;
      this.product_search = item.property_name;
      this.form.product_name = item.property_name;
      this.form.product_amount = item.property_amount;

      this.list_style = true;

      axios
        .post("/api/getPropertyId", item, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.form.property_id = res.data.property_id;
          this.form.sub_property_id = res.data.sub_property_id;
        })
        .catch((err) => {});
      this.calculateDue();
    },

    chooseProductTypeMethods() {
      if (this.form.property_type.toLowerCase() == "land") {
        this.form.selected_label = "";
        this.isLabel = false;
        this.product_search = "";
        this.isProject = false;
        this.isBuildingExist = false;
        this.form.selectedProject = "";
        axios
          .post("/api/filterProductType", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.inventories = res.data;
          })
          .catch((err) => {});
      } else if (this.form.property_type.toLowerCase() == "others") {
        this.form.selected_label = "";
        this.isLabel = true;
        this.product_search = "";

        this.isProject = true;
        this.isBuildingExist = true;
        axios
          .post("/api/filterProductType", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.inventories = res.data;
          })
          .catch((err) => {});
      }
    },
    ReferenceList() {
      this.reference_list_style = false;
    },
    assignReferenceToSearch(item) {
      this.ReferenceName = item.reference_name;
      this.reference_list_style = true;
      this.reference_search = item.reference_id;
      this.reference_form.reference_name = item.reference_name;
      this.reference_form.reference_id = item.reference_id;
      this.reference_form.date = this.form.basic_date;
      this.reference_form.client_name = this.form.client_name;
    },
    assignToSearchCategoryName(item) {
      this.list_style_category_name = true;
      this.category_name_search = item.category_name;
      this.form.category_name = item.category_name;
      this.form.category_id = item.category_id;
      this.category_id_search = item.category_id;
      this.list_style_category_id = true;
    },
    assignToSearchCategoryId(item) {
      this.list_style_category_id = true;
      this.list_style_category_name = true;
      this.form.category_name = item.category_name;
      this.form.category_id = item.category_id;
      this.category_name_search = item.category_name;
      this.category_id_search = item.category_id;
    },
  },
  computed: {
    filterCategoryName() {
      return this.categories.filter((product) => {
        let product_name = this.category_name_search.toUpperCase();
        let inventory_name = product.category_name.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
    filterCategoryId() {
      return this.categories.filter((product) => {
        let product_name = this.category_id_search.toUpperCase();
        let inventory_name = product.category_id.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
    filterSearch() {
      return this.allClients.filter((client) => {
        const search_Term = this.client_search.toLowerCase();
        const typeName = client.name.toLowerCase();
        const phone = client.phone.toLowerCase();
        const client_id = client.client_id.toLowerCase();
        if (phone) {
          return (
            typeName.includes(search_Term) ||
            phone.includes(search_Term) ||
            client_id.includes(search_Term)
          );
        } else if (!phone) {
          return typeName.includes(search_Term) || client_id.includes(search_Term);
        }
      });
    },
    calculateDue() {
      let total_amount = parseInt(this.form.product_amount);
      let receive_amount = parseInt(this.form.total_amount);

      axios
        .get("/api/checkDueClearReceipt/" + this.form.receipt_id)
        .then((res) => {
          if (res.data.receipt_id) {
            axios
              .get("/api/getFirstInstallReceipt/" + this.form.receipt_id)
              .then((res) => {
                let $firstInstall;
                this.dueClear = parseInt(res.data.due_clear);
                $firstInstall =
                  parseInt(res.data.total_received) - parseInt(this.dueClear);
                let sum = parseInt(this.dueClear) + parseInt(this.form.total_amount);

                if (sum > this.form.product_amount) {
                  this.showButton = false;
                } else {
                  this.showButton = true;
                }
              })
              .catch((err) => {});
          } else {
            this.showButton = true;
          }
        })
        .catch((err) => {});

      //2nd
      this.form.due =
        parseInt(this.form.product_amount) - parseInt(this.form.total_amount);
      if (this.form.total_amount.length == 0) {
        this.form.due = 0;
      }
      if (parseInt(this.form.product_amount) < parseInt(this.form.total_amount)) {
        this.showButton = false;
      } else {
        this.showButton = true;
      }
    },
    filterInventory() {
      return this.inventories.filter((product) => {
        let product_name = this.product_search.toUpperCase();
        let inventory_name = product.property_name.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
    yearRanges() {
      const currentYear = new Date().getFullYear();
      const nextYear = currentYear + 1;
      const yearRanges = [
        `${currentYear - 1}-${currentYear}`,
        `${currentYear}-${nextYear}`,
      ];

      return yearRanges;
    },
    choosePaymentType() {
      if (this.form.selectedPaymentType == "Cash") {
        this.bankChoose = false;
        this.showBankField = false;
      } else if (this.form.selectedPaymentType == "Cheque") {
        this.bankChoose = true;
        this.showBankField = true;
      }
    },
    checkClient() {
      if (this.client.statuses == "Exist") {
        this.client_exist = true;
        this.client_not_exist = false;
      } else if (this.client.statuses == "New") {
        this.client_not_exist = true;
        this.client_exist = false;
      }
    },
    chooseClientInfo() {
      this.allClients.forEach((item) => {
        if (item.national_id_no == this.client_nid) {
          this.form.client_email = item.email;
          this.form.client_phone = item.phone;
          this.form.client_tin = item.tin;
          this.form.client_name = item.name;
          this.form.client_id = item.client_id;
        }
      });

      axios
        .get("/api/fetch_client_project/" + this.client_search)
        .then((res) => {
          this.registeredProject = res.data;
        })
        .catch((err) => {});
    },
    chooseProductType() {
      if (this.form.property_type.toLowerCase() == "land") {
        this.form.selected_label = "";
        this.isProject = false;
        this.isBuildingExist = false;
        this.form.selectedProject = "";
        this.product_search = "";
        this.isLabel = false;
        axios
          .post("/api/filterProductType", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.inventories = res.data;
          })
          .catch((err) => {});
      } else if (this.form.property_type.toLowerCase() == "others") {
        this.form.selected_label = "";
        this.isLabel = true;
        this.product_search = "";

        this.isProject = true;
        this.isBuildingExist = true;
        axios
          .post("/api/filterProductType", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.inventories = res.data;
          })
          .catch((err) => {});
      }
    },

    chooseProject() {
      this.product_search = "";
      this.form.selected_label = "";

      axios
        .post("/api/filterProductType", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.inventories = res.data;
          axios
            .post("/api/getBuildingName", this.form, {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            })
            .then((res) => {
              this.all_building = res.data;
              if (this.all_building != "") {
                this.isBuildingExist = true;
              } else {
                this.isBuildingExist = false;
              }
            })
            .catch((err) => {});
        })
        .catch((err) => {});
    },
    selectBuilding() {
      this.product_search = "";
      this.form.selected_label = "";
      if (this.form.building_name != "") {
        this.isLabel = true;
      } else {
        this.isLabel = false;
      }
    },
    chooseLabel() {
      axios
        .post("/api/getPropertyLabel", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.product_search = "";
          this.inventories = res.data;
          if (this.form.selected_label == "all") {
            this.product_search = this.form.building_name;
            this.form.product_name = this.form.building_name;
            axios
              .post("/api/getProductTotal", this.form, {
                headers: {
                  "Content-Type": "application/json",
                  Accept: "application/json",
                },
              })
              .then((res) => {
                this.form.property_id = res.data.property_id;
                this.form.product_amount = res.data.product_amount;
              })
              .catch((err) => {});
          } else {
            this.form.product_name = this.product_search;
          }
        })
        .catch((err) => {});
    },
    checkReference() {
      if (this.reference_status == "Yes") {
        this.hasReference = true;
        if (this.hasReference) {
          axios
            .get("/api/reference_info")
            .then((res) => {
              this.all_references = res.data;
            })
            .catch((err) => {});
        }
      } else {
        this.hasReference = false;
      }
    },
    filterReference() {
      return this.all_references.filter((reference) => {
        let referenceName = reference.reference_id.toUpperCase();
        let search = this.reference_search.toUpperCase();
        return referenceName.includes(search);
      });
    },
  },
};
</script>
<style></style>
