import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import {MatToolbarModule} from '@angular/material/toolbar';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ToolbarComponent } from './widgets/toolbar/toolbar.component';
import { SupportUrlPageComponent } from './widgets/support-url-page/support-url-page.component';
import { HomePageComponent } from './widgets/home-page/home-page.component';
import { NotFoundPageComponent } from './widgets/not-found-page/not-found-page.component';
import { PrivacyPolicyPageComponent } from './widgets/privacy-policy-page/privacy-policy-page.component';
import { FooterComponent } from './widgets/footer/footer.component';

@NgModule({
  declarations: [
    AppComponent,
    ToolbarComponent,
    SupportUrlPageComponent,
    HomePageComponent,
    NotFoundPageComponent,
    PrivacyPolicyPageComponent,
    FooterComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule, 
    MatButtonModule, 
    MatCheckboxModule,
    MatToolbarModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
