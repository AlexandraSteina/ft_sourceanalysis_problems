   %load('hdm_grid_ft_november.mat') % there's a difference in the grid.pos field depending on the Fieldtrip version. 
   load('hdm_grid_ft_april.mat')
   load('freq.mat') % the link for the freq.mat file is found in the Readme
   % 
   % yourfieldtrippath = Try out different fieldtrip releases (fieldtrip-20190922, fieldtrip-20200409, fieldtrip-20200607, fieldtrip-20201103) using hdm_grid_ft_april.mat. 
   % Then use hdm_grid_ft_november.mat together with fieldtrip-20201103 and hdm_grid_ft_april.mat with fieldtrip version fieldtrip-20200409
   
    p = ft_read_mri('yourfieldtrippath\template\anatomy\single_subj_T1.nii');
    chan = 'LFP-right-1-2A';
    
   template = load('yourfieldtrippath\template\sourcemodel\standard_sourcemodel3d10mm');
    
    cfg=[];
    cfg.method='dics';
    cfg.dics.lambda='5%';
    cfg.headmodel=hdm;
    cfg.sourcemodel=grid;
    cfg.frequency = 12;
    cfg.reducerank=2;
    cfg.refchan = chan;
    source=ft_sourceanalysis(cfg,freq);
    source.pos = template.sourcemodel.pos;
    source.dim = template.sourcemodel.dim;

     cfg = [];
     cfg.parameter = 'coh';
     cfg.interpmethod        = 'nearest';
     it = ft_sourceinterpolate(cfg,source,p); 

     cfg =  [];
     cfg.method = 'ortho';
     cfg.funparameter = 'coh';
     cfg.maskparameter = 'coh';
     ft_sourceplot(cfg,it);
