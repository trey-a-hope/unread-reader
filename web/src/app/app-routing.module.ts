import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SupportUrlPageComponent } from './widgets/support-url-page/support-url-page.component';
import { HomePageComponent } from './widgets/home-page/home-page.component';
import { NotFoundPageComponent } from './widgets/not-found-page/not-found-page.component';
import { PrivacyPolicyPageComponent } from './widgets/privacy-policy-page/privacy-policy-page.component';


const routes: Routes = [ 
  { path: '', component: HomePageComponent },
  { path: 'support-url', component: SupportUrlPageComponent },
  { path: 'privacy-policy', component: PrivacyPolicyPageComponent },

  // { 
  //   path: 'product-detail', 
  //   component: ProductDetailComponent, 
  //   data: {
  //     product: 'test'
  //   }
  // },
  // { path: 'contact', component: ContactComponent },
  // { path: 'admin', component: AdminComponent },
  { path: '**', component: NotFoundPageComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
