Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335B285C92;
	Wed, 25 Jun 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870109; cv=none; b=REJDOP3h47yZA+bS6GygNCsLZiXPGluEOcz0KbqzvaBAnPwHmOMjZTy0pE/VDtnuLILfZJyg+xkQ8tXIv2v+yAud3/smVKKslHEuo75KXVcW37bhWFgl3F6BuwpHJHP7H3OSVSl50s0l/CRsYjzhgMcwkU8TLk6SMyEM3SOVogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870109; c=relaxed/simple;
	bh=cag+c+glbVM6ZrhblGmUpscg8NGo2h1Nshc6TntvkuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2oVeVuQNDlaX0nW+kVJ/OEi8+ipCn5FKajVMU+8wF0JIgXKVcrdvz9zRhAVJcpir/O/ryvIiRVdI5wxkE6GjRcIwPWsx7ge9FEOs3SehYiKGsYfQlQFxy8399JvNdA1MIHA6a3uXejCgkHuQXNcid+DR50NvaxYNOJ69zllFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvKps39S; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvKps39S"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58ba6c945so1986661cf.2;
        Wed, 25 Jun 2025 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870107; x=1751474907; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZQtxZ5A/V3eeXnba2r1tOxiy9yY9dau/NzMZf1604=;
        b=bvKps39SwQRfw86rnWxlvQ9AJaYLMrpAV43K56TQtquwg7nYmnT6aESjTXz93kykDJ
         dOfKSBTuFtWy6nMmgjCUCDUlUKUN5BFfuQqNBxxfBQx7yOePTTthxg0fJk2h5pp4jhoi
         uvpyGOCyKUOuiSMGZCNBHlh4PXgdwZo9C3cUImL+nRxqOaLpxbvy+Sc/fdUdmXL9Hdpp
         OZK2ZRQ3wmRRqSNbqd2ehZH7uKHJgSpkHX/zfE3lF6piucqAjq1vj9C9bKT1c4G5rwpa
         mPt53/h++7AG3nTSnh6Yloq2R1IZCiONtVPyuPxti51l936N1lhcgoPMWxggAnqSTU3/
         8Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870107; x=1751474907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfZQtxZ5A/V3eeXnba2r1tOxiy9yY9dau/NzMZf1604=;
        b=wXcnhWF+lA1BK3yrEihE+M3AAv/ZpzMoGPZZ+bblJgGYDa/I00FVH7gx7/alM7i1aZ
         hgUDGwsRy4poxlAe2O3ib1wMRdeB5X5tWtiyrUCMhVJZTOFRIE2Q3E4T+7a/ZSU5ISoP
         dNpZZY8Lb0eHFKuGvRPLsgM3Y35bon1WclrSMkFvLe9fZLIOsmcNEUZAn3FNuKfliW+c
         ML5SlEogJB4bW+cNAO5/dZ1cb0jiYRcKLyW6JCDFKgJSatKN/TKdKNY0k8qiuyLjK6mG
         IbRUvI2He2UbbH+EdoLEbxVV74YrxgMuVfTpdaJKA5y+GMZjQdALcEL8ERggYPULgK1y
         uCGw==
X-Forwarded-Encrypted: i=1; AJvYcCVYC4ebCpUsqFU+HY5lD0sEk8P9kY8Wm8Nlf/wWVOCfanM5EGgnfr91Qi1wvu5dtXL0ahXW6qDLT3uzK8q9TQ==@lists.linux.dev, AJvYcCWH5oemSKOxQbEGkqSK5qFokoV928vvL62UNZpCegSnsItEWAZtErIMIcAuyHz99aVS1zYJ@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm11381w8loSGEA0i4K7o4fQJ+teTU9Z86hc1FkeahLhQrkgsu
	5uxlOE6cXe4hcBeo19f5t4n61Zo3qjpe+WWjaZc5x/LcNk12BhrHz/MDvkUsnwxEo95E3hssucV
	x8Hr7M9scdOWw6oeWQxJklhVYlWMKBZY=
X-Gm-Gg: ASbGncsQIAHct4wrgyltZXqvLjeFXXyp48XdCASpu/imkiJ/3PqYas5/O950noMCn8d
	NF2v7qjM/Oujoyc9bYo7/siGLVVI8DV9lzkJK/DRrhg4Q9gDO5geRkv6ivC0+Gj0Q/jr1wjLxbb
	BPRTFPdb8YZ9ERt47rZTaWeFVBcU/zIM3M4F24tAZUxKkx1jwP/AzZdhtWUhY=
X-Google-Smtp-Source: AGHT+IHnGZf+fu9SeiyuF9kQmAOEZke0m2LllwCuXdhfFxesY+uAABRJJM6WKD41IneEOxIBlU5CuC7+Lj6KgvDsH4g=
X-Received: by 2002:ac8:5fce:0:b0:476:74de:81e2 with SMTP id
 d75a77b69052e-4a7c08b05f0mr65981621cf.43.1750870106629; Wed, 25 Jun 2025
 09:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250624022135.832899-14-joannelkoong@gmail.com> <202506252117.9V3HTO0i-lkp@intel.com>
In-Reply-To: <202506252117.9V3HTO0i-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Jun 2025 09:48:15 -0700
X-Gm-Features: AX0GCFu4lcNCxXc2Rv_TbdgF3DX477vRtHysoV5-7omwd5WacfSbp3GjvkDuyaU
Message-ID: <CAJnrk1Z5NZ0_f=OMMam9hf0xJwM=SsmgFpyfbnKE7MT_i_kZMQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] fuse: use iomap for writeback
To: kernel test robot <lkp@intel.com>
Cc: linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, hch@lst.de, 
	miklos@szeredi.hu, brauner@kernel.org, djwong@kernel.org, 
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:18=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Joanne,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on xfs-linux/for-next linus/master v6.16-rc3 next-=
20250625]
> [cannot apply to gfs2/for-next mszeredi-fuse/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/iomap=
-pass-more-arguments-using-struct-iomap_writepage_ctx/20250624-102709
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.a=
ll
> patch link:    https://lore.kernel.org/r/20250624022135.832899-14-joannel=
koong%40gmail.com
> patch subject: [PATCH v3 13/16] fuse: use iomap for writeback
> config: arm64-randconfig-003-20250625 (https://download.01.org/0day-ci/ar=
chive/20250625/202506252117.9V3HTO0i-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250625/202506252117.9V3HTO0i-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506252117.9V3HTO0i-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepages':
> >> file.c:(.text+0xa30): undefined reference to `iomap_writepages'
> >> file.c:(.text+0xa30): relocation truncated to fit: R_AARCH64_CALL26 ag=
ainst undefined symbol `iomap_writepages'
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepage_finish':
> >> file.c:(.text+0x1fd8): undefined reference to `iomap_finish_folio_writ=
e'
> >> file.c:(.text+0x1fd8): relocation truncated to fit: R_AARCH64_CALL26 a=
gainst undefined symbol `iomap_finish_folio_write'
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_cache_write_iter':
>    file.c:(.text+0x888c): undefined reference to `iomap_file_buffered_wri=
te'
>    file.c:(.text+0x888c): relocation truncated to fit: R_AARCH64_CALL26 a=
gainst undefined symbol `iomap_file_buffered_write'
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_iomap_writeback_ra=
nge':
> >> file.c:(.text+0x9258): undefined reference to `iomap_start_folio_write=
'
> >> file.c:(.text+0x9258): relocation truncated to fit: R_AARCH64_CALL26 a=
gainst undefined symbol `iomap_start_folio_write'
> >> aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x370): undefined reference =
to `iomap_dirty_folio'
>    aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x3a0): undefined reference =
to `iomap_release_folio'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

As noted in the cover letter [1]

   Please note the following:
   * this patchset version temporarily drops the CONFIG_BLOCK iomap refacto=
ring
     patches that will be needed to merge in the series. As of now, this br=
eaks
     compilation for environments where CONFIG_BLOCK is not set, but the
     CONFIG_BLOCK iomap changes will be re-added back in once the core chan=
ges
     in this patchset are ready to go.


These errors will be fixed in later versions when the CONFIG_BLOCK
patches get added in.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelko=
ong@gmail.com/
