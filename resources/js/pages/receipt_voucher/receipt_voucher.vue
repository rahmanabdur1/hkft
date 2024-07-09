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
                  id="status"
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
                  id="status"
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
                <label class="hkf_text">Your Cash/Bank Account</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Cash/Bank Account"
                  v-model="form.cash_bank_account"
                  required
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
                    id="status"
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
                <label for="projectName" class="hkf_text">Depositors Name</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Depositors Name"
                  required
                  v-model="form.client_name"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="client_exist">
                <label for="projectName" class="hkf_text">Depositor</label>
                <div style="display: flex">
                  <input
                    type="text"
                    class="form-control status"
                    placeholder="Client ID,Name,Phone"
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
                <label for="projectName" class="hkf_text">Select Building</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.building_name"
                  @change="selectBuilding"
                  onfocus="this.size()=5"
                  onblur="this.size()=1"
                  onchange="this.size=1;this.blur();"
                  required
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
                  id="status"
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

              <div class="form-group mx-sm-3 mb-2" v-if="this.not_selected">
                <label class="hkf_text">Property Amount:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Amount"
                  v-model="form.product_amount"
                />
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
                    id="status"
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
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label class="hkf_text col-md-6" v-if="hasAdvance"
                    >Advance Paid : {{ advance_tk }} tk</label
                  >
                  <label for="projectName" class="hkf_text col-md-6"
                    >Receive Amount</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Receive Amount"
                    v-model="total_amount"
                    @keyup="calculateDue"
                    required
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

                  <embed :src="Supporting_docs" type="application/pdf" />
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
        vm.$router.push({ name: "receipt_voucher" });
      }
    });
  },

  data() {
    return {
      category_name_search: "",
      category_id_search: "",
      not_selected: false,
      hasAdvance: false,
      advance_tk: 0,
      isBuildingExist: false,
      isLabel: false,
      product_types: [
        { value: "land", label: "Land" },
        { value: "others", label: "Building" },
      ],
      product_types_manager: [{ value: "others", label: "Building" }],
      client_not_exist: true,
      client_exist: false,
      allClients: [],
      allProjects: [],
      client: {
        statuses: "",
        name: "",
      },
      list_style: true,
      isProject: false,
      selectedClient: null,
      registeredProject: [],
      client_nid: "",
      clientStatus: [{ status: "Exist" }, { status: "New" }],
      bankChoose: false,
      inventories: [],
      reference_list_style: true,
      form: {
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
        Supporting_docs: "",
        payto: "",
        payees_account_no: "",
        client_id: "",
        payment_receipt_details: "",
        product_amount: "",
        due: "",
        building_name: "",
        selected_label: "",
        property_id: "",
        account_type: "",
        sub_property_id: "",
        property_type: "",
        received_by: "",
      },
      total_amount: "",
      all_building: "",
      labels: [
        { value: "all", label: "All" },
        { value: "floor", label: "Floor" },
        { value: "flat", label: "Flat" },
        { value: "shop", label: "Shop" },
      ],
      product_search: "",
      Supporting_docs: "",
      showBankField: false,
      payment_types: [
        { payment_type: "Cash", label: "Cash" },
        { payment_type: "Cheque", label: "Cheque" },
      ],
      hasReference: false,
      allowReference: [
        { label: "Yes", value: "Yes" },
        { label: "No", value: "No" },
      ],
      Data: {
        product_amount: "",
        client_id: "",
        selectedProject: "",
        selectedBuilding: "",
      },
      client_search: "",
      list_client_style: true,
      data: {
        advance_amount: "",
        client_id: "",
        selectedProject: "",
        selectedBuilding: "",
      },
      reference_form: {
        reference_name: "",
        reference_id: "",
        product_name: "",
        date: "",
        reference_amount: "",
        client_name: "",
        voucher_no: "",
      },
      categories: [],
      deleteAdvance: false,
      updateAdvance: false,
      ReferenceName: "",
      reference_status: "",
      all_references: [],
      reference_search: "",
      showButton: true,
      isAdmin: false,
      isManager: false,
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
  },
  methods: {
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
    receiveVoucher() {
      const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
      let randomString = "";
      for (let i = 0; i < 5; i++) {
        const randomIndex = Math.floor(Math.random() * alphabet.length);
        const randomLetter = alphabet.charAt(randomIndex);
        randomString += randomLetter;
      }
      const uniqueId = randomString + Math.floor(Math.random() * 100000);

      this.form.receipt_id = uniqueId;
      this.reference_form.voucher_no = this.form.receipt_id;
      this.form.account_type =
        "Installation-" + Math.floor(Math.random() * 9999999) + uniqueId;

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
      formData.append("product_amount", this.form.product_amount);
      formData.append("due", this.form.due);
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
      formData.append("building_name", this.form.building_name);
      formData.append("selected_label", this.form.selected_label);
      formData.append("property_id", this.form.property_id);
      formData.append("sub_property_id", this.form.sub_property_id);
      formData.append("account_type", this.form.account_type);
      formData.append("property_type", this.form.property_type);
      formData.append("received_by", this.form.received_by);
      if (this.hasReference) {
        axios
          .post("/api/reference", this.reference_form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            console.log(res.data);
          })
          .catch((err) => {});
      }
      //receipt_voucher
      axios
        .post("/api/receipt_voucher", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          console.log(res.data);
          this.$router.push({ name: "all_voucher" });
        })
        .catch((err) => {});

      if (this.updateAdvance == true) {
        axios
          .post("/api/updatedAdvance", this.Data, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {})
          .catch((err) => {
            console.log(err.response);
          });
      } else if (this.deleteAdvance == true) {
        axios
          .post("/api/deleteInAdvance", this.data, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {})
          .catch((err) => {
            console.log(err.response);
          });
      }
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
    ReferenceList() {
      this.reference_list_style = false;
    },
    assignReferenceToSearch(item) {
      this.reference_list_style = true;
      this.reference_search = item.reference_id;
      this.reference_form.reference_name = item.reference_name;
      this.reference_form.reference_id = item.reference_id;
      this.reference_form.date = this.form.basic_date;
      this.reference_form.client_name = this.form.client_name;
      this.ReferenceName = item.reference_name;
    },

    assignToSearch(item) {
      this.not_selected = false;
      this.product_search = item.property_name;
      this.form.product_name = item.property_name;
      this.form.product_amount = item.property_amount;
      this.reference_form.product_name = item.property_name;

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
  },

  computed: {
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
      if (this.hasAdvance == true) {
        if (parseInt(this.advance_tk) > parseInt(this.form.product_amount)) {
          this.form.total_amount = parseInt(this.form.product_amount);
          let updatedAdvanceAmount =
            parseInt(this.advance_tk) - parseInt(this.form.product_amount);

          this.Data.product_amount = this.form.total_amount;
          this.Data.client_id = this.form.client_id;
          this.Data.selectedProject = this.form.selectedProject;
          this.Data.selectedBuilding = this.form.building_name;
          this.deleteAdvance = false;
          this.updateAdvance = true;
        } else if (parseInt(this.advance_tk) < parseInt(this.form.product_amount)) {
          this.form.total_amount =
            parseInt(this.total_amount) + parseInt(this.advance_tk);
          this.deleteAdvance = true;
          this.updateAdvance = false;
          this.data.advance_amount = this.advance_tk;
          this.data.client_id = this.form.client_id;
          this.data.selectedProject = this.form.selectedProject;
          this.data.selectedBuilding = this.form.building_name;
        }
      } else {
        this.form.total_amount = this.total_amount;
      }

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

        const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
        let randomString = "";
        for (let i = 0; i < 5; i++) {
          const randomIndex = Math.floor(Math.random() * alphabet.length);
          const randomLetter = alphabet.charAt(randomIndex);
          randomString += randomLetter;
        }
        const uniqueId = randomString + Math.floor(Math.random() * 100000);

        this.form.client_id = "Unregistered_Client-" + uniqueId;
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
    },
    chooseProductType() {
      this.product_search = "";
      if (this.form.property_type.toLowerCase() == "land") {
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

      const requestData = {
        selectedProject: this.form.selectedProject,
        selectedBuilding: this.form.building_name,
        client_id: this.form.client_id,
      };
      axios
        .post("/api/fetchAdvanceInVoucher", requestData)
        .then((res) => {
          this.advance_tk = res.data.amount;
          if (parseInt(this.advance_tk) > 0) {
            this.hasAdvance = true;
          }
        })
        .catch((err) => {
          console.log(err.response);
        });
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
<style>
.formBox {
  border: 1px solid #4e3089;
  margin: 1rem;
  box-sizing: border-box;
  width: 100%;
}
.depositorBox {
  font-size: 0.85em;
}

.box_container {
  display: flex;
}
.title_col {
  width: 60%;
}
.ulShow {
  overflow-y: scroll;
  height: 150px;
  display: block;
}
.listShow {
  display: block;
  cursor: pointer;
  padding: 0.2rem;
  color: #4e3089;
}
.plusBtn {
  width: 100%;
  display: flex;
}
.plusSection {
  width: 100%;
  display: flex;
}
.listStyle {
  display: none;
}

.faBtn {
  text-align: right;
  margin-top: 3em;
  padding-right: 3%;
  margin-bottom: 1em;
}
.faBtnCross button {
  background: red;
  margin-top: 2em;
  color: white;
  border: none;
  border-radius: 10%;
}
.faBtn button {
  background: #5252d7;
  color: white;
  border: none;
  border-radius: 10%;
}
.cashSection {
  padding: 2rem 0;
}
.additionalPart {
  width: 100%;
  color: black;
  margin: 1rem 2rem;
}
@media only screen and (max-width: 900px) {
  .title_col {
    width: 100%;
  }
}
</style>
