Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :doctors, only: [:show]

  resources :patients, only: [:index]
  # resources :doctor_patients, only: [:destroy]
  delete "/doctors/:doctor_id/patients/:patient_id", to: "doctor_patients#destroy"
end
