import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SupportUrlPageComponent } from './support-url-page.component';

describe('SupportUrlPageComponent', () => {
  let component: SupportUrlPageComponent;
  let fixture: ComponentFixture<SupportUrlPageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SupportUrlPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SupportUrlPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
